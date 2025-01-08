package kr.co.team4.model.mapper;

import kr.co.team4.model.dto.BoardDTO;
import kr.co.team4.model.dto.CommentDTO;
import kr.co.team4.model.dto.CommentResDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.math.BigInteger;
import java.util.List;

@Mapper
public interface BoardMapper {

    // 게시글 작성
    void write(BoardDTO board);

    // 게시글 목록
    List<BoardDTO> getBoardList();

    // 특정글 조회
    BoardDTO detail(@Param("BOARD_IDX") int BOARD_IDX);

    void insertComment(CommentResDTO commentResDTO);  // 파라미터 추가

    List<CommentResDTO> selectComment(@Param("BOARD_IDX") int BOARD_IDX);

}
