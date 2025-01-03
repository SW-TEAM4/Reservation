package kr.co.team4.model.dto;



import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigInteger;

@Data // @Getter, @Setter, @ToString, @EqualsAndHashCode, @RequiredArgsConstructor 포함
@NoArgsConstructor // 기본 생성자 자동 생성
@AllArgsConstructor // 모든 필드를 포함한 생성자 자동 생성
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
