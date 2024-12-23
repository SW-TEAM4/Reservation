package kr.co.team4.model.service;

import kr.co.team4.model.dto.LodgmentDTO;

import java.util.Map;

public interface LodgmentService {
    Map<String, Object> lodgmentDetail(LodgmentDTO lodgmentDTO);
}
