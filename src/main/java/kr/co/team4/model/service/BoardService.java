package kr.co.team4.model.service;

import kr.co.team4.model.dto.BoardDTO;

import java.util.List;
import java.util.Map;
import java.util.Objects;

public interface BoardService {

    // 게시글 작성
    void write(BoardDTO board) throws Exception;

    // 게시판 조회
    List<BoardDTO> getBoardList() throws Exception;

    // 특정글 조회
    BoardDTO detail(int BOARD_IDX) throws Exception;
}
