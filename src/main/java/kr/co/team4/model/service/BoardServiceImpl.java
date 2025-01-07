package kr.co.team4.model.service;

import kr.co.team4.model.dto.BoardDTO;
import kr.co.team4.model.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class BoardServiceImpl implements BoardService {

    @Autowired
    private BoardMapper boardMapper;

    @Override
    public void write(BoardDTO board) throws Exception {
        System.out.println("Service에서 전달받은 BoardDTO : " + board);
        boardMapper.write(board);
    }

    @Override
    public List<BoardDTO> getBoardList() throws Exception {

        return boardMapper.getBoardList();
    }

    @Override
    public BoardDTO detail(int BOARD_IDX) throws Exception{

        return boardMapper.detail(BOARD_IDX);
    }

}
