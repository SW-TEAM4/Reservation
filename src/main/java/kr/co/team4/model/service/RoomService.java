package kr.co.team4.model.service;

import kr.co.team4.model.dto.RoomDTO;

import java.util.List;
import java.util.Map;

public interface RoomService {
    List<RoomDTO> availableRooms(Map<String, Object> params);
}

