package com.devstudy.controller;

import java.util.Objects;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.devstudy.service.BoardService;
import com.devstudy.vo.BoardVO;

@Controller
@RequestMapping("/board")
public class BoardController {

    private final BoardService boardService;

    public BoardController(BoardService boardService) {
        this.boardService = boardService;
    }

    @GetMapping("/list")
    public String boardList(
            @RequestParam(defaultValue = "1") int boardType,
            Model model) throws Exception {

        if (boardType < 1 || boardType > 6) {
            throw new ResponseStatusException(
                    HttpStatus.BAD_REQUEST, "올바르지 않은 게시판입니다.");
        }

        String[] boardNames = {
            "", "커뮤니티", "AI", "자격증", "모임", "Q&A", "공지사항"
        };

        BoardVO vo = new BoardVO();
        vo.setBoardType(boardType);

        model.addAttribute("boardType", boardType);
        model.addAttribute("boardName", boardNames[boardType]);
        model.addAttribute("boardList", boardService.selectBoardList(vo));

        return "board/list";
    }
    
    @GetMapping("/write")
    public String writeForm(
            @RequestParam(defaultValue = "1") int boardType,
            HttpSession session,
            Model model) {

        if (session.getAttribute("loginMemberIdx") == null) {
            return "redirect:/member/signin";
        }

        checkWritePermission(boardType, session);

        if (session.getAttribute("boardWriteToken") == null) {
            session.setAttribute(
                    "boardWriteToken", UUID.randomUUID().toString());
        }

        model.addAttribute("boardType", boardType);
        model.addAttribute("boardName", getBoardName(boardType));

        return "board/write";
    }

    @PostMapping("/write")
    public String write(
            @RequestParam int boardType,
            @RequestParam(defaultValue = "") String title,
            @RequestParam(defaultValue = "") String content,
            @RequestParam(defaultValue = "") String category,
            @RequestParam(value = "writeToken", required = false)
            String writeToken,
            HttpSession session,
            Model model,
            RedirectAttributes redirectAttributes) throws Exception {

        Long loginMemberIdx =
                (Long) session.getAttribute("loginMemberIdx");

        if (loginMemberIdx == null) {
            return "redirect:/member/signin";
        }

        checkWritePermission(boardType, session);

        String expectedToken =
                (String) session.getAttribute("boardWriteToken");

        if (expectedToken == null || !expectedToken.equals(writeToken)) {
            throw new ResponseStatusException(
                    HttpStatus.FORBIDDEN,
                    "글쓰기 화면을 새로 열고 다시 시도해주세요.");
        }

        BoardVO vo = new BoardVO();
        vo.setBoardType(boardType);
        vo.setTitle(title);
        vo.setContent(content);
        vo.setCategory(category);

        try {
            boardService.insertBoard(
                    vo,
                    loginMemberIdx,
                    (String) session.getAttribute("loginRole"));
        } catch (IllegalArgumentException e) {
            model.addAttribute("boardType", boardType);
            model.addAttribute("boardName", getBoardName(boardType));
            model.addAttribute("form", vo);
            model.addAttribute("errorMessage", e.getMessage());
            return "board/write";
        }

        session.removeAttribute("boardWriteToken");

        redirectAttributes.addFlashAttribute(
                "successMessage", "게시글이 등록되었습니다.");

        return "redirect:/board/list?boardType=" + boardType;
    }

    private void checkWritePermission(int boardType, HttpSession session) {

        if (boardType < 1 || boardType > 6) {
            throw new ResponseStatusException(
                    HttpStatus.BAD_REQUEST, "올바르지 않은 게시판입니다.");
        }

        if (boardType == 6
                && !"ADMIN".equals(session.getAttribute("loginRole"))) {
            throw new ResponseStatusException(
                    HttpStatus.FORBIDDEN, "공지사항은 관리자만 작성할 수 있습니다.");
        }
    }

    private String getBoardName(int boardType) {
        String[] names = {
            "", "커뮤니티", "AI", "자격증", "모임", "Q&A", "공지사항"
        };

        return names[boardType];
    }
    
    @GetMapping("/detail")
    public String detail(
            @RequestParam int boardIdx,
            HttpSession session,
            Model model) throws Exception {

        BoardVO board = findBoard(boardIdx);

        prepareBoardActionToken(session);
        model.addAttribute("board", board);
        model.addAttribute("boardName", getBoardName(board.getBoardType()));

        return "board/detail";
    }

    @GetMapping("/update")
    public String updateForm(
            @RequestParam int boardIdx,
            HttpSession session,
            Model model) throws Exception {

        if (session.getAttribute("loginMemberIdx") == null) {
            return "redirect:/member/signin";
        }

        BoardVO board = findBoard(boardIdx);
        checkBoardOwner(board, session);

        prepareBoardActionToken(session);
        model.addAttribute("board", board);
        model.addAttribute("boardName", getBoardName(board.getBoardType()));

        return "board/update";
    }

    @PostMapping("/update")
    public String update(
            @RequestParam int boardIdx,
            @RequestParam(defaultValue = "") String title,
            @RequestParam(defaultValue = "") String content,
            @RequestParam(defaultValue = "") String category,
            @RequestParam(value = "actionToken", required = false)
            String actionToken,
            HttpSession session,
            Model model,
            RedirectAttributes redirectAttributes) throws Exception {

        if (session.getAttribute("loginMemberIdx") == null) {
            return "redirect:/member/signin";
        }

        checkBoardActionToken(session, actionToken);

        BoardVO board = findBoard(boardIdx);
        checkBoardOwner(board, session);

        board.setTitle(title);
        board.setContent(content);
        board.setCategory(category);

        try {
            boardService.updateBoard(
                    board, (Long) session.getAttribute("loginMemberIdx"));
        } catch (IllegalArgumentException e) {
            model.addAttribute("board", board);
            model.addAttribute("boardName", getBoardName(board.getBoardType()));
            model.addAttribute("errorMessage", e.getMessage());
            return "board/update";
        }

        redirectAttributes.addFlashAttribute(
                "successMessage", "게시글이 수정되었습니다.");

        return "redirect:/board/detail?boardIdx=" + boardIdx;
    }

    @PostMapping("/delete")
    public String delete(
            @RequestParam int boardIdx,
            @RequestParam(value = "actionToken", required = false)
            String actionToken,
            HttpSession session,
            RedirectAttributes redirectAttributes) throws Exception {

        if (session.getAttribute("loginMemberIdx") == null) {
            return "redirect:/member/signin";
        }

        checkBoardActionToken(session, actionToken);

        BoardVO board = findBoard(boardIdx);
        checkBoardOwner(board, session);

        try {
            boardService.deleteBoard(
                    board, (Long) session.getAttribute("loginMemberIdx"));
        } catch (IllegalArgumentException e) {
            throw new ResponseStatusException(
                    HttpStatus.CONFLICT, e.getMessage(), e);
        }

        redirectAttributes.addFlashAttribute(
                "successMessage", "게시글이 삭제되었습니다.");

        return "redirect:/board/list?boardType=" + board.getBoardType();
    }

    private BoardVO findBoard(int boardIdx) throws Exception {

        if (boardIdx <= 0) {
            throw new ResponseStatusException(
                    HttpStatus.BAD_REQUEST, "올바르지 않은 게시글 번호입니다.");
        }

        BoardVO condition = new BoardVO();
        condition.setBoardIdx(boardIdx);

        BoardVO board = boardService.selectBoard(condition);

        if (board == null) {
            throw new ResponseStatusException(
                    HttpStatus.NOT_FOUND, "게시글을 찾을 수 없습니다.");
        }

        return board;
    }

    private void checkBoardOwner(BoardVO board, HttpSession session) {

        Long loginMemberIdx =
                (Long) session.getAttribute("loginMemberIdx");

        if (loginMemberIdx == null
                || !Objects.equals(loginMemberIdx, board.getMemberIdx())) {
            throw new ResponseStatusException(
                    HttpStatus.FORBIDDEN, "본인이 작성한 글만 변경할 수 있습니다.");
        }

        if (board.getBoardType() == 6
                && !"ADMIN".equals(session.getAttribute("loginRole"))) {
            throw new ResponseStatusException(
                    HttpStatus.FORBIDDEN, "공지사항 변경 권한이 없습니다.");
        }
    }

    private void prepareBoardActionToken(HttpSession session) {

        if (session.getAttribute("boardActionToken") == null) {
            session.setAttribute(
                    "boardActionToken", UUID.randomUUID().toString());
        }
    }

    private void checkBoardActionToken(
            HttpSession session, String actionToken) {

        String expected =
                (String) session.getAttribute("boardActionToken");

        if (expected == null || !expected.equals(actionToken)) {
            throw new ResponseStatusException(
                    HttpStatus.FORBIDDEN,
                    "화면을 새로 열고 다시 시도해주세요.");
        }
    }
}