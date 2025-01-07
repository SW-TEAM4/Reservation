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





}
