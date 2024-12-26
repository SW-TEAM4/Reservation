package kr.co.team4.model.dto;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReviewDTO {
    private int review_idx;
    private int user_idx;
    private int reservation_idx;
    private int room_idx;
    private String user_comment;
    private double rating;
    private String review_img_url;
    private String lod_comment;
    private String user_comment;
    private String status;
    private float rating;
}
