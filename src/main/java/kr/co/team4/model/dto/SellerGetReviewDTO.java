package kr.co.team4.model.dto;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class SellerGetReviewDTO {
     String     user_name;                  // 사용자이름
     BigDecimal rating;                     // 평점
     String     room_name;                  // 객실 명
     String     user_comment;               // 리뷰내용
     String     review_img_url;             // 리뷰 이미지url
     String     comment_status;             // 사장님 답글
     Integer    review_idx;                 // 리뷰idx
}
