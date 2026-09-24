package com.devstudy.service;

import com.devstudy.form.SignupForm;
import com.devstudy.vo.MemberVO;

public interface MemberService {

    public int memberCnt(MemberVO vo) throws Exception;
    public int signup(SignupForm form) throws Exception;
}