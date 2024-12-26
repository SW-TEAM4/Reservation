package kr.co.team4.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;

@Data // @Getter, @Setter, @ToString, @EqualsAndHashCode, @RequiredArgsConstructor 포함
@NoArgsConstructor // 기본 생성자 자동 생성
@AllArgsConstructor // 모든 필드를 포함한 생성자 자동 생성
public class LodgmentDTO {
    private int lod_idx;
    private int seller_idx;
    private int region_idx;
    private int lod_category_idx;
    private String lod_name;
    private String biz_email;
    private String biz_num;
    private String lod_phone_number;
    private String lod_img_url;
    private String lod_address;
    private String seller_notice;  // 숙소 알려주개
    private String reservation_notice; // 숙소 예약공지
    private String lod_check_in;
    private String lod_check_out;
    private double avg_rating;
    private double x; // 숙소 위도
    private double y; // 숙소 경도
    private Date created;
    private Date updated;
    private String status;
}
