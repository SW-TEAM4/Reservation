package kr.co.team4.model.service;

import kr.co.team4.model.dto.LodgmentDTO;
import kr.co.team4.model.dto.RoomDTO;

public interface RoomService {

    // room_idx로 객실 상세 정보 가져오기
    RoomDTO getRoomDetail(int room_idx);
    LodgmentDTO getRoomLodDetail(int lod_idx);
}


