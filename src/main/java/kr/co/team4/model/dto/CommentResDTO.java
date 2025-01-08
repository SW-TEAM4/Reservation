package kr.co.team4.model.dto;
import lombok.*;

import java.math.BigInteger;
import java.sql.Timestamp;
@Data
@NoArgsConstructor
@AllArgsConstructor
public class CommentResDTO {
    private BigInteger COMMENT_IDX;
    private BigInteger BOARD_IDX;
    private BigInteger USER_IDX;
    private String USER_NAME;
    private String COMMENT;
    private Timestamp CREATED;
}
