package kr.co.team4.model.mapper;

import kr.co.team4.model.dto.LodReviewDTO;
import org.apache.ibatis.annotations.Mapper;


import java.util.List;
import java.util.Map;

@Mapper
public interface LodReviewMapper {
    Map<String, Object> getReviewStatistics(int lodIdx); // 리뷰 통계
    List<LodReviewDTO> getReviewList(int lodIdx);          // 개별 리뷰 목록
}
