package com.devstudy.service;

import java.util.List;

import com.devstudy.vo.BoardVO;

public interface BoardService {

    public List<BoardVO> selectBoardList(BoardVO vo) throws Exception;
    public BoardVO selectBoard(BoardVO vo) throws Exception;
    public int insertBoard(BoardVO vo, Long loginMemberIdx, String loginRole) throws Exception;
    public int updateBoard(BoardVO vo, Long loginMemberIdx) throws Exception;
    public int deleteBoard(BoardVO vo, Long loginMemberIdx) throws Exception;
    public long selectBoardCount(BoardVO vo) throws Exception;
    
}