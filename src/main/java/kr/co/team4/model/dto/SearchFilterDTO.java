package kr.co.team4.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data // @Getter, @Setter, @ToString, @EqualsAndHashCode, @RequiredArgsConstructor 포함
@NoArgsConstructor // 기본 생성자 자동 생성
@AllArgsConstructor
public class SearchFilterDTO {
    private String checkinDate;
    private String checkoutDate;
    private int guestCount;
    private int petCount;
    private String type;
    private String weight;
    private String region;
}
