package kr.co.team4.model.service;

import kr.co.team4.model.dto.LodgmentDTO;
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
        List<LodgmentDTO> lodgmentDetail = lodgmentMapper.lodgmentDetail(lodgmentDTO);
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("list", lodgmentDetail);
        return resultMap;
    }
}
