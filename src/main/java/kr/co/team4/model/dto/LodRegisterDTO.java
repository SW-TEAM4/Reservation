package kr.co.team4.model.dto;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

import java.math.BigDecimal;
import java.util.List;

@Data
public class LodRegisterDTO {
    Integer       seller_idx;                    // 사장님idx
    Integer       region_idx;                    // 지역 IDX(1: 강원도 2: 경기 3: 인천)
    Integer       lod_category_idx;              // 숙소종류 IDX(1: 펜션 2: 글램핑)
    String        lod_name;                      // 숙소이름
    String        biz_email;                     // 사업주 이메일
    String        biz_num;                       // 사업자번호
    String        lod_phone_number;              // 사업자전화번호
    String        lod_img_url;                   // 숙소 대표 사진URL
    String        lod_address;                   // 숙소주소
    String        seller_notice;                 // 사장님알려주개
    String        reservation_notice;            // 예약공지
    String        lod_check_in;                  // 체크인 시간
    String        lod_check_out;                 // 체크아웃 시간
    BigDecimal    avg_rating;                    // 평균평점
    BigDecimal    x;                             // 위도
    BigDecimal    y;                             // 경도
    List<String>  lod_facility;                  // 시설/서비스 목록
    /// //////////////////////////////////////////////////////////
    Integer       lod_idx;                       // 숙소idx
    Integer       lod_facility_idx;              // 시설/서비스 idx
    MultipartFile lod_img;                       // 숙소 이미지명
}
