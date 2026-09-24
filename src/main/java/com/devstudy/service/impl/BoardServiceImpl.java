package com.devstudy.service.impl;

import java.nio.charset.StandardCharsets;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.devstudy.mapper.BoardMapper;
import com.devstudy.service.BoardService;
import com.devstudy.vo.BoardVO;

@Service
public class BoardServiceImpl implements BoardService {

    private final BoardMapper boardMapper;

    public BoardServiceImpl(BoardMapper boardMapper) {
        this.boardMapper = boardMapper;
    }

    @Override
    @Transactional(readOnly = true)
    public List<BoardVO> selectBoardList(BoardVO vo) throws Exception {

        if (vo == null
                || vo.getBoardType() == null
                || vo.getBoardType() < 1
                || vo.getBoardType() > 6) {
            throw new IllegalArgumentException(
                    "올바르지 않은 게시판 번호입니다.");
        }

        return boardMapper.selectBoardList(vo);
    }
    
    @Override
    @Transactional(readOnly = true)
    public BoardVO selectBoard(BoardVO vo) throws Exception {

        validateBoardIdx(vo);

        return boardMapper.selectBoard(vo);
    }
    
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int insertBoard(
            BoardVO vo,
            Long loginMemberIdx,
            String loginRole) throws Exception {

        if (loginMemberIdx == null) {
            throw new IllegalArgumentException("로그인이 필요합니다.");
        }

        if (vo == null
                || vo.getBoardType() == null
                || vo.getBoardType() < 1
                || vo.getBoardType() > 6) {
            throw new IllegalArgumentException(
                    "올바르지 않은 게시판입니다.");
        }

        if (vo.getBoardType() == 6 && !"ADMIN".equals(loginRole)) {
            throw new IllegalArgumentException(
                    "공지사항은 관리자만 작성할 수 있습니다.");
        }

        String title = vo.getTitle() == null
                ? "" : vo.getTitle().strip();

        String content = vo.getContent() == null
                ? "" : vo.getContent();

        String category = vo.getCategory() == null
                ? "" : vo.getCategory().strip();

        if (title.isEmpty() || title.length() > 256) {
            throw new IllegalArgumentException(
                    "제목은 1~256자로 입력해주세요.");
        }

        if (content.isBlank()) {
            throw new IllegalArgumentException(
                    "내용을 입력해주세요.");
        }

        if (content.getBytes(StandardCharsets.UTF_8).length > 65535) {
            throw new IllegalArgumentException(
                    "본문이 너무 깁니다. 내용을 줄여주세요.");
        }

        if (category.length() > 256) {
            throw new IllegalArgumentException(
                    "분류는 256자 이내로 입력해주세요.");
        }

        vo.setTitle(title);
        vo.setContent(content);
        vo.setCategory(category.isEmpty() ? null : category);
        vo.setMemberIdx(loginMemberIdx);
        vo.setBoardIdx(null);

        return boardMapper.insertBoard(vo);
    }
    
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int updateBoard(
            BoardVO vo, Long loginMemberIdx) throws Exception {

        validateBoardIdx(vo);

        if (loginMemberIdx == null) {
            throw new IllegalArgumentException("로그인이 필요합니다.");
        }

        String title = vo.getTitle() == null
                ? "" : vo.getTitle().strip();

        String content = vo.getContent() == null
                ? "" : vo.getContent();

        String category = vo.getCategory() == null
                ? "" : vo.getCategory().strip();

        if (title.isEmpty() || title.length() > 256) {
            throw new IllegalArgumentException(
                    "제목은 1~256자로 입력해주세요.");
        }

        if (content.isBlank()) {
            throw new IllegalArgumentException("내용을 입력해주세요.");
        }

        if (content.getBytes(StandardCharsets.UTF_8).length > 65535) {
            throw new IllegalArgumentException(
                    "본문이 너무 깁니다. 내용을 줄여주세요.");
        }

        if (category.length() > 256) {
            throw new IllegalArgumentException(
                    "분류는 256자 이내로 입력해주세요.");
        }

        vo.setTitle(title);
        vo.setContent(content);
        vo.setCategory(category.isEmpty() ? null : category);

        vo.setMemberIdx(loginMemberIdx);

        int updatedCount = boardMapper.updateBoard(vo);

        if (updatedCount == 0) {
            throw new IllegalArgumentException(
                    "게시글이 없거나 수정 권한이 없습니다.");
        }

        return updatedCount;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int deleteBoard(
            BoardVO vo, Long loginMemberIdx) throws Exception {

        validateBoardIdx(vo);

        if (loginMemberIdx == null) {
            throw new IllegalArgumentException("로그인이 필요합니다.");
        }

        vo.setMemberIdx(loginMemberIdx);

        int deletedCount = boardMapper.deleteBoard(vo);

        if (deletedCount == 0) {
            throw new IllegalArgumentException(
                    "게시글이 없거나 삭제 권한이 없습니다.");
        }

        return deletedCount;
    }

    private void validateBoardIdx(BoardVO vo) {

        if (vo == null
                || vo.getBoardIdx() == null
                || vo.getBoardIdx() <= 0) {
            throw new IllegalArgumentException(
                    "올바르지 않은 게시글 번호입니다.");
        }
    }
   
}