package kr.co.team4.model.dto;

import lombok.Data;

@Data
public class ChecktFacilityResDTO {
    /*[check] 삭제필요 */
    String  check_facility;           // 시설/서비스테이블에 시설/서비스이름 존재여부
    Integer lod_facility_idx;         // 시설/서비스IDX
}
