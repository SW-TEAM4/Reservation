package kr.co.team4.model.service;

import kr.co.team4.model.dto.RoomDTO;
import kr.co.team4.model.mapper.RoomMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RoomServiceImpl implements RoomService {
    @Autowired
    private RoomMapper roomMapper;

    @Override
    public RoomDTO getRoomDetail(int roomIdx) {
        return roomMapper.getRoomDetail(roomIdx); // Mapper 호출
    }
}
