package kr.co.team4.model.service;

import kr.co.team4.model.dto.RoomDTO;
import kr.co.team4.model.mapper.RoomMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class RoomServiceImpl implements RoomService {
    @Autowired
    private RoomMapper roomMapper;

    @Override
    public List<RoomDTO> availableRooms(Map<String, Object> params) {
        return roomMapper.availableRooms(params);
    }
}