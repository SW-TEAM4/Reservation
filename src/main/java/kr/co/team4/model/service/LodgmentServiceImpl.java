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
    public Map<String, Object> lodgmentDetail(LodgmentDTO lodgmentDTO) {
        Map<String, Object> resultMap = new HashMap<>();
        LodgmentDTO lodgmentDetail = lodgmentMapper.lodgmentDetail(lodgmentDTO).get(0); // 한 개의 데이터 반환
        resultMap.put("lodgment", lodgmentDetail);  // 숙소 정보 담기
        return resultMap;
    }
    @Override
    public List<RoomDTO> getRoomsByLodgment(int lodIdx) {
        return lodgmentMapper.getRoomsByLodgment(lodIdx);
    }

    @Override
    public SellerDTO getSellerInfo(int lodIdx) {
        return lodgmentMapper.getSellerInfo(lodIdx); // Mapper가 정확히 SellerDTO를 반환하는지 확인
    }

    @Override
    public List<RoomDTO> getAvailableRooms(Map<String, Object> params) {
        return lodgmentMapper.getAvailableRooms(params);
    }

}
