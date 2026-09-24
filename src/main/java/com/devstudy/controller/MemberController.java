package com.devstudy.controller;

import java.util.UUID;

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
}