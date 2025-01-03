package kr.co.team4.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data // @Getter, @Setter, @ToString, @EqualsAndHashCode, @RequiredArgsConstructor 포함
@NoArgsConstructor // 기본 생성자 자동 생성
@AllArgsConstructor // 모든 필드를 포함한 생성자 자동 생성
public class LodReviewDTO {
    private int lod_idx;
    private String reviewer_nickname;
    private String reviewer_content;
    private double reviewer_rating;
    private String reviewer_image;
    private String reviewer_created;
    private String manager_reply;
}

