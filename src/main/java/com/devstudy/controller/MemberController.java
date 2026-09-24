package com.devstudy.controller;

import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.devstudy.form.SignupForm;
import com.devstudy.service.MemberService;
import com.devstudy.vo.MemberVO;

@Controller
@RequestMapping("/member")
public class MemberController {

    private final MemberService memberService;

    public MemberController(MemberService memberService) {
        this.memberService = memberService;
    }

    @GetMapping("/signup")
    public String signupForm(HttpSession session) {

        if (session.getAttribute("signupToken") == null) {
            session.setAttribute(
                    "signupToken", UUID.randomUUID().toString());
        }

        return "member/signup";
    }

    @PostMapping("/signup")
    public String signup(
            @ModelAttribute("signupForm") SignupForm form,
            @RequestParam(value = "signupToken", required = false)
            String signupToken,
            HttpSession session,
            Model model,
            RedirectAttributes redirectAttributes) throws Exception {

        try {
        	
            String expectedToken =
                    (String) session.getAttribute("signupToken");

            if (expectedToken == null
                    || !expectedToken.equals(signupToken)) {
                model.addAttribute(
                        "errorMessage",
                        "회원가입 화면을 새로 열고 다시 시도해주세요.");
                return "member/signup";
            }

            try {
                memberService.signup(form);
            } catch (IllegalArgumentException e) {
                model.addAttribute("errorMessage", e.getMessage());
                return "member/signup";
            }

            session.removeAttribute("signupToken");
            redirectAttributes.addFlashAttribute(
                    "successMessage", "회원가입이 완료되었습니다.");

            return "redirect:/home";

        } finally {

            form.setPassword(null);
            form.setPasswordConfirm(null);
        }
    }
    
    @GetMapping("/signin")
    public String signinForm(HttpSession session) {

        if (session.getAttribute("signinToken") == null) {
            session.setAttribute(
                    "signinToken", UUID.randomUUID().toString());
        }

        return "member/signin";
    }
    
    @PostMapping("/signin")
    public String signin(
            @RequestParam(value = "email", defaultValue = "") String email,
            @RequestParam(value = "password", defaultValue = "") String password,
            @RequestParam(value = "signinToken", required = false)
            String signinToken,
            HttpServletRequest request,
            Model model) throws Exception {

        HttpSession session = request.getSession();
        String expectedToken =
                (String) session.getAttribute("signinToken");

        if (expectedToken == null || !expectedToken.equals(signinToken)) {
            model.addAttribute(
                    "errorMessage", "로그인 화면을 새로 열고 다시 시도해주세요.");
            return "member/signin";
        }

        MemberVO vo = new MemberVO();
        vo.setEmail(email);
        vo.setPassword(password);

        MemberVO member;
        try {
            member = memberService.signin(vo);
        } finally {
            vo.setPassword(null);
        }

        if (member == null) {
            model.addAttribute(
                    "errorMessage", "이메일 또는 비밀번호를 확인해주세요.");
            return "member/signin";
        }

        request.changeSessionId();
        session.setMaxInactiveInterval(30 * 60);

        session.setAttribute("loginMemberIdx", member.getMemberIdx());
        session.setAttribute("loginNickname", member.getNickname());
        session.setAttribute("loginRole", member.getRole());
        session.removeAttribute("signinToken");

        return "redirect:/home";
    }
}