package kr.co.team4.model.mapper;

import kr.co.team4.model.dto.ReviewDTO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ReviewMapper {
    int insertReview(ReviewDTO reviewDTO);
}
