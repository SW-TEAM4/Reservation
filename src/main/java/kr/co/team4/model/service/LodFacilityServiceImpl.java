package kr.co.team4.model.service;

import kr.co.team4.model.dto.LodFacilityDTO;
import kr.co.team4.model.dto.LodReviewDTO;
import kr.co.team4.model.mapper.LodFacilityMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.HashMap;
import java.util.Map;

@Service
public class LodFacilityServiceImpl implements LodFacilityService {

    @Autowired
    private LodFacilityMapper lodFacilityMapper;

    @Override
    public List<LodFacilityDTO> getFacilityList(int lodIdx) {
        return lodFacilityMapper.getFacilityList(lodIdx);
    }
}



