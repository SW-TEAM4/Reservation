package kr.co.team4.model.mapper;

import kr.co.team4.model.dto.ReviewDTO;
import kr.co.team4.model.dto.UserReservedDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.math.BigInteger;
import java.util.List;

@Mapper
public interface ReviewMapper {
    int insertReview(ReviewDTO reviewDTO);

    void updateReservationStatus(@Param("userIdx") BigInteger userIdx,
                                 @Param("reservationIdx") int reservationIdx,
                                 @Param("roomIdx") int roomIdx);


    UserReservedDTO getRoomAndLodgmentName(@Param("room_Idx") int room_Idx);

    UserReservedDTO getUserName(@Param("user_Idx")int user_Idx);

    List<ReviewDTO> getReviewList(ReviewDTO dto); // 반환 타입 변경

    int getReviewCount(ReviewDTO dto);

    /**
     * 리뷰 이미지 URL 업데이트
     *
     * @param reservationIdx 예약 ID
     * @param reviewImgUrl   리뷰 이미지 URL
     * @return 업데이트된 행의 수
     */
    int updateReviewImageUrl(@Param("reservationIdx") int reservationIdx,
                             @Param("reviewImgUrl") String reviewImgUrl);





}
