package kr.co.team4.model.dto;

import lombok.Data;

import java.math.BigInteger;

@Data
public class UserDTO {
    private BigInteger user_idx;
    private String user_name;
    private String user_email;
    private String user_phone_number;
}
