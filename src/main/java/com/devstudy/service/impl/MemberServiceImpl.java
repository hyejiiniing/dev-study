package com.devstudy.service.impl;

import java.nio.charset.StandardCharsets;
import java.util.Locale;
import java.util.UUID;

import org.springframework.dao.DuplicateKeyException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.devstudy.form.SignupForm;
import com.devstudy.mapper.MemberMapper;
import com.devstudy.service.MemberService;
import com.devstudy.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {

    private final MemberMapper memberMapper;
    private final PasswordEncoder passwordEncoder;
    private final String dummyPasswordHash;

    public MemberServiceImpl(MemberMapper memberMapper,
                             PasswordEncoder passwordEncoder) {
        this.memberMapper = memberMapper;
        this.passwordEncoder = passwordEncoder;
        this.dummyPasswordHash =
                passwordEncoder.encode(UUID.randomUUID().toString());
    }

    @Override
    public int memberCnt(MemberVO vo) throws Exception {
        return memberMapper.memberCnt(vo);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int signup(SignupForm form) throws Exception {

        if (form == null) {
            throw new IllegalArgumentException(
                    "회원가입 정보를 입력해주세요.");
        }

        String email = form.getEmail() == null
                ? ""
                : form.getEmail().strip().toLowerCase(Locale.ROOT);

        String nickname = form.getNickname() == null
                ? ""
                : form.getNickname().strip();

        String password = form.getPassword();

        if (email.length() > 254
                || !email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {
            throw new IllegalArgumentException(
                    "올바른 이메일을 입력해주세요.");
        }

        if (nickname.length() < 2 || nickname.length() > 30) {
            throw new IllegalArgumentException(
                    "닉네임은 2~30자로 입력해주세요.");
        }

        if (password == null || password.length() < 10) {
            throw new IllegalArgumentException(
                    "비밀번호는 10자 이상 입력해주세요.");
        }

        if (password.getBytes(StandardCharsets.UTF_8).length > 72) {
            throw new IllegalArgumentException(
                    "비밀번호는 UTF-8 기준 72바이트 이내로 입력해주세요.");
        }

        if (!password.equals(form.getPasswordConfirm())) {
            throw new IllegalArgumentException(
                    "비밀번호 확인이 일치하지 않습니다.");
        }

        MemberVO vo = new MemberVO();
        vo.setEmail(email);
        vo.setNickname(nickname);
        vo.setPassword(passwordEncoder.encode(password));

        try {
            return memberMapper.insertMember(vo);
        } catch (DuplicateKeyException e) {
            throw new IllegalArgumentException(
                    "이미 사용 중인 이메일 또는 닉네임입니다.", e);
        }
    }
    
    @Override
    @Transactional(readOnly = true)
    public MemberVO signin(MemberVO vo) throws Exception {

        if (vo == null || vo.getEmail() == null
                || vo.getPassword() == null) {
            return null;
        }

        String email = vo.getEmail().strip().toLowerCase(Locale.ROOT);
        String rawPassword = vo.getPassword();

        if (email.isEmpty() || email.length() > 254
                || rawPassword.isEmpty()
                || rawPassword.getBytes(StandardCharsets.UTF_8).length > 72) {
            return null;
        }

        MemberVO condition = new MemberVO();
        condition.setEmail(email);

        MemberVO member = memberMapper.selectMemberByEmail(condition);

        if (member == null) {
   
            passwordEncoder.matches(rawPassword, dummyPasswordHash);
            return null;
        }

        boolean passwordMatches =
                passwordEncoder.matches(rawPassword, member.getPassword());

        member.setPassword(null);

        if (!passwordMatches || !"ACTIVE".equals(member.getStatus())) {
            return null;
        }

        return member;
    }

}