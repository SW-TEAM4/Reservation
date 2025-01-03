package kr.co.team4.model.service;

import kr.co.team4.model.dto.LodFacilityDTO;
import kr.co.team4.model.dto.LodReviewDTO;

import java.util.List;
import java.util.Map;

public interface LodFacilityService {
    // 숙소의 시설/서비스 목록을 반환하는 메서드
    List<LodFacilityDTO> getFacilityList(int lodIdx);
}
