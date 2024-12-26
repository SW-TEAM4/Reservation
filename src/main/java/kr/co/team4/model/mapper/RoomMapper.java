package kr.co.team4.model.mapper;

import kr.co.team4.model.dto.RoomDTO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface RoomMapper {
    // room_idx로 객실 상세 정보 가져오기
    RoomDTO getRoomDetail(int roomIdx);
}
