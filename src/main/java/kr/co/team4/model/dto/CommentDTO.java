package kr.co.team4.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigInteger;

@Data // @Getter, @Setter, @ToString, @EqualsAndHashCode, @RequiredArgsConstructor 포함
@NoArgsConstructor // 기본 생성자 자동 생성
@AllArgsConstructor // 모든 필드를 포함한 생성자 자동 생성
public class CommentDTO {
    private BigInteger comment_idx;
    private BigInteger board_idx;
    private BigInteger user_idx;
    private String comment;
}
