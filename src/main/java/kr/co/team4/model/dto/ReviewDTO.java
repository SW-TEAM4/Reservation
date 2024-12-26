package kr.co.team4.model.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReviewDTO {
    private int review_idx;
    private int user_idx;
    private int reservation_idx;
    private int room_idx;
    private String review_img_url;
    private String user_comment;
    private float rating;
}
