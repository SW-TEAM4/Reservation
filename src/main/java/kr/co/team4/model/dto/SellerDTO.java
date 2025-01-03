package kr.co.team4.model.dto;



import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigInteger;
import java.sql.Timestamp;


@Data
public class SellerDTO {
    private BigInteger SELLER_IDX;
    private String SELLER_NAME;
    private String SELLER_NICK_NAME;
    private String SELLER_PHONE_NUMBER;
    private String SELLER_ID;
    private String SELLER_PWD;
    private String SELLER_PWD2;
    private String SELLER_EMAIL;
    private Timestamp CREATED;
    private Timestamp UPDATED;
    private String STATUS;
}
