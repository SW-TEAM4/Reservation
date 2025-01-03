package kr.co.team4.model.service;

import kr.co.team4.model.dto.LodReviewDTO;

import java.util.List;
import java.util.Map;

public interface LodReviewService {
    Map<String, Object> getReviewStatistics(int lodIdx);
    List<LodReviewDTO> getReviewList(int lodIdx);
}


