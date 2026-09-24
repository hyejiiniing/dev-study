package com.devstudy.service;

import java.util.List;

import com.devstudy.vo.BoardVO;

public interface BoardService {

    public List<BoardVO> selectBoardList(BoardVO vo) throws Exception;
    public int insertBoard(
            BoardVO vo,
            Long loginMemberIdx,
            String loginRole) throws Exception;
}