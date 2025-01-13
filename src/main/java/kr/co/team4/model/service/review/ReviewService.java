package kr.co.team4.model.service.review;


import kr.co.team4.model.dto.ReviewDTO;
import kr.co.team4.model.dto.UserReservedDTO;
import org.apache.ibatis.annotations.Param;

import java.math.BigInteger;
import java.util.Map;
/*
예약내역 있는지 체크
status값 바꾸는거 리뷰 작성 후 A-> N으로 바뀜
리뷰는 한개만 가능
리뷰작성후 바로 예약내역 페이지로 이동
 */

public interface ReviewService {

   int insertReview(ReviewDTO reviewDTO);
   void updateReservationStatus(@Param("userIdx") BigInteger userIdx,
                                @Param("reservationIdx") int reservationIdx,
                                @Param("roomIdx") int roomIdx);

   UserReservedDTO getRoomAndLodgmentName(int room_Idx);

   UserReservedDTO getUserName(int user_idx);

   Map<String, Object> getReviewList(ReviewDTO dto);


   int getReviewCount(ReviewDTO dto);

   int updateReviewImageUrl(@Param("reservationIdx") int reservationIdx,
                            @Param("reviewImgUrl") String reviewImgUrl);





}
