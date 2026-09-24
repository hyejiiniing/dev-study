package com.devstudy.mapper;

import java.util.List;

import com.devstudy.vo.BoardVO;

public interface BoardMapper {

	public List<BoardVO> selectBoardList(BoardVO vo) throws Exception;
	public int insertBoard(BoardVO vo) throws Exception;
	
}