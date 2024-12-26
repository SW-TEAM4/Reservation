package kr.co.team4.model.dto;

import lombok.Data;

import java.math.BigInteger;
import java.util.Date;

@Data
public class ReservationDTO {
    private BigInteger reservation_idx;
    private BigInteger lod_idx;
    private BigInteger room_idx;
    private BigInteger user_idx;
    private String res_name;
    private String res_phone_number;
    private Date res_str_date;
    private Date res_end_date;
    private int res_people_cnt;
    private int res_pets_cnt;
    private String request;
    private String status;
}

