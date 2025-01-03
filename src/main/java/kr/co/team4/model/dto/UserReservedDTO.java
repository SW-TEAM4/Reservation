package kr.co.team4.model.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.math.BigInteger;

@Data
@Getter
@Setter
public class UserReservedDTO {
    private BigInteger user_idx;
    private BigInteger reservation_idx;
    private BigInteger lod_idx;
    private BigInteger room_idx;
    private String user_name;
    private String lod_name;
    private String lod_category_name;
    private String lod_img_url;
    private String room_name;
    private String room_price;
    private String res_merchant_id;
    private String res_name;
    private String res_phone_number;
    private String res_str_date;
    private String res_end_date;
    private int res_people_cnt;
    private int res_pets_cnt;
    private String request;
    private String status;

}
