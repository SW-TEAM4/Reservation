package kr.co.team4.model.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.math.BigInteger;
import java.sql.Date;
import java.time.LocalDateTime;

@Getter
@Setter
@Data
public class GetResDetailResDTO {
    private BigInteger user_idx;
    private BigInteger reservation_idx;
    private BigInteger lod_idx;
    private BigInteger room_idx;
    private BigInteger payment_idx;
    private LocalDateTime created;
    private String lod_name;
    private String room_name;
    private String room_photo_url;
    private String lod_check_in;
    private String lod_check_out;
    private String res_str_date;
    private String res_end_date;
    private int total_res_day;
    private int res_people_cnt;
    private int res_pets_cnt;
    private int paid_money;
    private String request;


}
