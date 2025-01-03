package kr.co.team4.model.dto;

import lombok.Data;

import java.sql.Timestamp;
import java.util.Timer;

@Data
public class UserDTO {
    private String USER_NAME;
    private String NICK_NAME;
    private String USER_PHONE_NUMBER;
    private String USER_ID;
    private String USER_PWD;
    private String USER_PWD2;
    private String USER_EMAIL;
    private Timestamp CREATED;
    private Timestamp UPDATED;
    private String STATUS;


}
