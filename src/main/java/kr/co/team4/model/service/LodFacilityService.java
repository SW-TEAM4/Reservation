package kr.co.team4.model.service;

import kr.co.team4.model.dto.LodFacilityDTO;

import java.util.Map;

public interface LodFacilityService {
    Map<String, Object> facilityLists(LodFacilityDTO lodFacilityDTO);
}
