package kr.co.team4.model.mapper;

import kr.co.team4.model.dto.RoomDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface RoomMapper {
    List<RoomDTO> availableRooms(Map<String, Object> params);
}