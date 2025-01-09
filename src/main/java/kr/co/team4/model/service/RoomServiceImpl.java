package kr.co.team4.model.service;

import kr.co.team4.model.dto.LodgmentDTO;
import kr.co.team4.model.dto.RoomDTO;
import kr.co.team4.model.mapper.RoomMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigInteger;

@Service
public class RoomServiceImpl implements RoomService {
    @Autowired
    private RoomMapper roomMapper;

    @Override
    public RoomDTO getRoomDetail(int room_idx) {
        RoomDTO room = roomMapper.getRoomDetail(room_idx);

        // room_notice 포맷팅 (줄바꿈 -> <br>)
        if (room.getRoom_notice() != null) {
            String formattedNotice = room.getRoom_notice().replace("\n", "<br>");
            room.setRoom_notice(formattedNotice);
        }

        return room;
    }

    @Override
    public LodgmentDTO getRoomLodDetail(int lodIdx) {
        return roomMapper.getRoomLodDetail(lodIdx);
    }
}
