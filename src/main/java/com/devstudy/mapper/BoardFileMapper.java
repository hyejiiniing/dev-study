package com.devstudy.mapper;

import java.util.List;

import com.devstudy.vo.BoardFileVO;

public interface BoardFileMapper {

    public int insertBoardFile(BoardFileVO vo) throws Exception;

    public List<BoardFileVO> selectBoardFileList(
            BoardFileVO vo) throws Exception;
    public BoardFileVO selectBoardFile(
            BoardFileVO vo) throws Exception;
    public int deleteBoardFile(BoardFileVO vo) throws Exception;
    public int deleteBoardFiles(BoardFileVO vo) throws Exception;
}