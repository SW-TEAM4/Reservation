package kr.co.team4.model.dto;

import lombok.Getter;
import lombok.Setter;
import org.springframework.lang.Nullable;
import org.springframework.web.multipart.MultipartFile;

import java.math.BigInteger;
import java.sql.Date;
import java.sql.Timestamp;

@Getter
@Setter
public class ReviewDTO {
    private int review_idx;
    private BigInteger user_idx;
    private int reservation_idx;
    private int room_idx;
    private String user_comment;
    private float rating;
    @Nullable private String review_img_url;
    private String lod_comment;
    private String status;
    private Timestamp created;
    private String room_name;
    private String lod_name;
    private String formattedDate; // 변환된 날짜 포맷


}
