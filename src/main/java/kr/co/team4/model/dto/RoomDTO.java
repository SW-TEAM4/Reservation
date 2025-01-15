package kr.co.team4.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.text.DecimalFormat;
import java.util.List;

@Data // @Getter, @Setter, @ToString, @EqualsAndHashCode, @RequiredArgsConstructor 포함
@NoArgsConstructor // 기본 생성자 자동 생성
@AllArgsConstructor // 모든 필드를 포함한 생성자 자동 생성
public class RoomDTO {
    private int room_idx;
    private int lod_idx;
    private String room_name;
    private String room_notice;
    private int room_price;
    private int max_people_cnt; // 최대 인원 수
    private int max_pet_cnt; // 최대 반려동물 수
    private double avg_rating;
    private int number_of_review;
    private java.sql.Date created;
    private java.sql.Date updated;
    private String status;

    // 이미지 URL 리스트
    private List<String> room_img_urls;

    private int total_room_price;

    public String getFormattedRoomPrice(){
        // 가격을 1,000 단위로 쉼표를 추가하는 포맷터 설정
        DecimalFormat decimalFormat = new DecimalFormat("#,###");
        // 가격을 쉼표 형식으로 포맷팅
        return decimalFormat.format(total_room_price);
    }
}

