package com.devstudy.mapper;

import com.devstudy.vo.MemberVO;

public interface MemberMapper {

	public int memberCnt(MemberVO vo) throws Exception;
	public int insertMember(MemberVO vo) throws Exception;
	public MemberVO selectMemberByEmail(MemberVO vo) throws Exception;
	
}