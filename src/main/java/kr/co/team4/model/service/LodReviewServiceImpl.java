package kr.co.team4.model.service;

import kr.co.team4.model.dto.LodReviewDTO;
import kr.co.team4.model.mapper.LodReviewMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class LodReviewServiceImpl implements LodReviewService {

    @Autowired
    private LodReviewMapper lodReviewMapper;

    @Override
    public Map<String, Object> getReviewStatistics(int lodIdx) {
        return lodReviewMapper.getReviewStatistics(lodIdx);
    }

    @Override
    public List<LodReviewDTO> getReviewList(int lodIdx) {
        return lodReviewMapper.getReviewList(lodIdx);
    }
}
