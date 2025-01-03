package kr.co.team4.model.service.review;

import kr.co.team4.model.dto.ReviewDTO;
import kr.co.team4.model.dto.UserReservedDTO;
import kr.co.team4.model.mapper.ReviewMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.math.BigInteger;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ReviewServiceImpl implements ReviewService {
    @Autowired
    private ReviewMapper reviewMapper;

    @Override
    public int insertReview(ReviewDTO reviewDTO) {
        return reviewMapper.insertReview(reviewDTO);
    }

    @Override
    public void updateReservationStatus(BigInteger userIdx, int reservationIdx, int roomIdx) {
        reviewMapper.updateReservationStatus(userIdx, reservationIdx, roomIdx);
    }

    /**
     * 작성자 :이윤채
     * 작성날짜 : 2024.12.30
     * ReviewPostPage
     * 특정 roomIdx와 lodIdx에 해당하는 숙소 이름과 방 이름 조회
     */
    @Override
    public UserReservedDTO getRoomAndLodgmentName(int room_Idx) {
        return reviewMapper.getRoomAndLodgmentName(room_Idx);
    }

    @Override
    public UserReservedDTO getUserName(int user_Idx) {
        return reviewMapper.getUserName(user_Idx);
    }

    @Override
    public Map<String, Object> getReviewList(ReviewDTO dto) {
        List<ReviewDTO> list = reviewMapper.getReviewList(dto);

        LocalDateTime now = LocalDateTime.now();

        // 각 리뷰의 날짜를 현재 시간 기준으로 변환
        for (ReviewDTO review : list) {
            try {
                // Timestamp를 LocalDateTime으로 변환
                LocalDateTime reviewDate = review.getCreated().toLocalDateTime();

                // 현재 시간과 리뷰 시간 사이의 간격 계산
                Duration duration = Duration.between(reviewDate, now);

                long years = duration.toDays() / 365;
                long months = duration.toDays() / 30;
                long days = duration.toDays();
                long hours = duration.toHours();
                long minutes = duration.toMinutes();

                // 적절한 시간 단위로 변환하여 설정
                if (years > 0) {
                    review.setFormattedDate(years + "년 전");
                } else if (months > 0) {
                    review.setFormattedDate(months + "개월 전");
                } else if (days > 0) {
                    review.setFormattedDate(days + "일 전");
                } else if (hours > 0) {
                    review.setFormattedDate(hours + "시간 전");
                } else if (minutes > 0) {
                    review.setFormattedDate(minutes + "분 전");
                } else {
                    review.setFormattedDate("방금 전");
                }
            } catch (Exception e) {
                review.setFormattedDate("날짜 오류");
            }
        }
        // 결과를 담을 맵에 추가
        Map<String, Object> result = new HashMap<>();
        result.put("getReviewList", list);

        return result;
    }

    @Override
    public int getReviewCount(ReviewDTO dto){
        return reviewMapper.getReviewCount(dto);
    }







}
