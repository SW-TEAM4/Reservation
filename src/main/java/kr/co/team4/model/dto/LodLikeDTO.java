package kr.co.team4.model.dto;


import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import java.math.BigInteger;
import java.sql.Timestamp;

@Data
public class LodLikeDTO {
    private BigInteger like_idx;
    private BigInteger user_idx;
    private int lod_idx;
    private Timestamp created;
    private Timestamp updated;
    private String status;
}
