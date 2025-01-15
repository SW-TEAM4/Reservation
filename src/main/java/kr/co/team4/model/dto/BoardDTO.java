package kr.co.team4.model.dto;

import lombok.Data;

import java.math.BigInteger;
import java.sql.Timestamp;

@Data
public class BoardDTO {
    private BigInteger BOARD_IDX;
    private String BOARD_TITLE;
    private String BOARD_CONTENT;
    private Timestamp CREATED;
    private Timestamp UPDATED;
    private String STATUS;
    private String WRITER_NAME;
    private BigInteger USER_IDX;
    private String USER_NAME;
    private String NICK_NAME;
}
