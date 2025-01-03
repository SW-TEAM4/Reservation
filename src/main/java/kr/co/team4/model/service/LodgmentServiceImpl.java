package kr.co.team4.model.service;

import kr.co.team4.model.dto.LodgmentDTO;
import kr.co.team4.model.dto.RoomDTO;
import kr.co.team4.model.dto.SellerDTO;
import kr.co.team4.model.mapper.LodgmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class LodgmentServiceImpl implements LodgmentService {
    @Autowired
    private LodgmentMapper lodgmentMapper;

    @Override
    public LodgmentDTO lodgmentDetail(LodgmentDTO lodgmentDTO) {
        // 한 개의 데이터 반환
        return lodgmentMapper.lodgmentDetail(lodgmentDTO);
    }
    @Override
    public List<RoomDTO> getRoomsByLodgment(LodgmentDTO lodgmentDTO) {
        return lodgmentMapper.getRoomsByLodgment(lodgmentDTO);
    }

    @Override
    public SellerDTO getSellerInfo(int lod_idx) {
        return lodgmentMapper.getSellerInfo(lod_idx); // Mapper가 정확히 SellerDTO를 반환하는지 확인
    }

    @Override
    public List<RoomDTO> getAvailableRooms(Map<String, Object> params) {
        return lodgmentMapper.getAvailableRooms(params);
    }

}
