package kr.co.team4.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data // @Getter, @Setter, @ToString, @EqualsAndHashCode, @RequiredArgsConstructor 포함
@NoArgsConstructor // 기본 생성자 자동 생성
@AllArgsConstructor // 모든 필드를 포함한 생성자 자동 생성
public class RoomDTO {
    private int room_idx;
    private int lod_idx;
    private String room_name;
    private String room_notice;
    private int room_price;
    private String room_img_url;
    private int max_people_cnt; // 최대 인원 수
    private int max_pet_cnt; // 최대 마리 수
    private double avg_rating;
    private int number_of_review;
    private java.sql.Date created;
    private java.sql.Date updated;
    private String status;
}
