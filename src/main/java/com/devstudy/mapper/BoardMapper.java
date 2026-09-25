package com.devstudy.mapper;

import java.util.List;

import com.devstudy.vo.BoardVO;

public interface BoardMapper {

	public List<BoardVO> selectBoardList(BoardVO vo) throws Exception;
	public BoardVO selectBoard(BoardVO vo) throws Exception;
	public long selectBoardCount(BoardVO vo) throws Exception;
	public int insertBoard(BoardVO vo) throws Exception;
	public int updateBoard(BoardVO vo) throws Exception;
	public int deleteBoard(BoardVO vo) throws Exception;
	public BoardVO selectBoardForUpdate(BoardVO vo) throws Exception;
	
	public List<BoardVO> selectFaqList() throws Exception;
	
}