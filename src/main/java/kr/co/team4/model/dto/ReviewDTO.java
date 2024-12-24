package kr.co.team4.model.dto;

import java.sql.Date;

public class ReviewDTO {
    private int review_idx;
    private int user_idx;
    private int reservation_idx;
    private int room_idx;
    private String user_comment;
    private double rating;
    private String review_img_url;
    private String lod_comment;
    private Date created;
    private Date updated;
    private String status;
}
