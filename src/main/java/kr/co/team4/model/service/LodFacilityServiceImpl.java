package kr.co.team4.model.service;

import kr.co.team4.model.dto.LodFacilityDTO;
import kr.co.team4.model.mapper.LodFacilityMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class LodFacilityServiceImpl implements LodFacilityService {
    @Autowired
    private LodFacilityMapper lodFacilityMapper;
    @Override
    public Map<String, Object> facilityLists(LodFacilityDTO lodFacilityDTO) {
        List<LodFacilityDTO> facilityList = lodFacilityMapper.facilityList(lodFacilityDTO);
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("list", facilityList);
        return resultMap;
    }
}



