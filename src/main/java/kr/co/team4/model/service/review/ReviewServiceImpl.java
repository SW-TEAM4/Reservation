package kr.co.team4.model.service.review;


import kr.co.team4.model.dto.ReviewDTO;
import kr.co.team4.model.mapper.ReviewMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReviewServiceImpl implements ReviewService {
    @Autowired
    private ReviewMapper reviewMapper;
    @Override
    public int insertReview(ReviewDTO reviewDTO) {
        return reviewMapper.insertReview(reviewDTO);
    }

}
