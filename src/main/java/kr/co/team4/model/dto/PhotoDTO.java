package kr.co.team4.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigInteger;
import java.sql.Date;

@Data // @Getter, @Setter, @ToString, @EqualsAndHashCode, @RequiredArgsConstructor 포함
@NoArgsConstructor // 기본 생성자 자동 생성
@AllArgsConstructor // 모든 필드를 포함한 생성자 자동 생성
public class PhotoDTO {
    private BigInteger photo_idx;
    private BigInteger lod_idx;
    private BigInteger room_idx;
    private String room_photo_url;
    private Date created;
    private Date updated;
    private String status;
}
