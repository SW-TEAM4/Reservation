package kr.co.team4.model.dto;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

import java.math.BigDecimal;
import java.util.List;

@Data
public class LodReservationDTO {
     Integer    lod_idx;           // 숙소IDX
     String     created;           // 예약일자
     String     res_name;          // 예약자 명
     String     room_name;         // 객실명
     BigDecimal paid_money;        // 결제금액
     String     res_str_date;      // 예약시작일자
     String     res_end_date;      // 예약종료일자
     Integer    res_people_cnt;    // 예약한 인원수
     Integer    res_pets_cnt;      // 예약한 마릿수
     String     request;           // 예약자 요청사항
}
