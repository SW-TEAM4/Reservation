package kr.co.team4.model.service;

import kr.co.team4.model.dto.LodgmentDTO;
import kr.co.team4.model.dto.RoomDTO;

import java.util.List;
import java.util.Map;

public interface LodgmentService {
    Map<String, Object> lodgmentDetail(LodgmentDTO lodgmentDTO);

    List<RoomDTO> getRoomsByLodgment(int lodIdx);
}
