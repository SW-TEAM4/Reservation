package kr.co.team4.model.dto;

import lombok.Data;

@Data
public class SavePeakPriceDTO {
   Integer lod_idx;             // 숙소 IDX
   String  peak_str_dt;         // 성수기 시작 날짜
   String  peak_end_dt;         // 성수기 종료 날짜
   String  hpeak_str_dt;        // 극성수기 시작 날짜
   String  hpeak_end_dt;        // 극성수기 종료 날짜
}
