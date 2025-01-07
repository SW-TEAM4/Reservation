package kr.co.team4.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PriceDTO {
    private int price_idx;
    private int lod_idx;
    private Date peak_str_dt;
    private Date peak_end_dt;
    private Date hpeak_str_dt;
    private Date hpeak_end_dt;
    private Date created;
    private Date updated;
    private String status;
}
