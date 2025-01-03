package kr.co.team4.model.dto;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Data
public class RoomRegisterDTO {
   Integer             lod_idx;                    // 숙소 IDX
   Integer             room_idx;                   // 객실 IDX
   String              room_name;                  // 객실명
   Integer             room_price;                 // 객실가격
   Integer             max_people_cnt;             // 최대인원
   Integer             max_pet_cnt;                // 최대마릿수
   String              room_notice;                // 객실기본정보
   Integer             max_pets_weight;            // 반려동물 사이즈
   String              room_img_url;               // 객실이미지URL
   List<MultipartFile> room_photos;                // 객실 사진들
   MultipartFile       room_photo_url;             // 객실 사진
}
