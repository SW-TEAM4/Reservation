package kr.co.team4.model.mapper;

import kr.co.team4.model.dto.*;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface SellerPageMapper {

   //사장님 페이지
   String checkLod(int seller_idx);                       // 숙소존재여부 체크
   int    getLod  (int seller_idx);                       // 숙소IDX 가져오기

   //숙소등록
   void   insertLod(LodRegisterDTO dto);                                           // 숙소테이블  저장
   String checktFacility(String Facitlity);                                        // 시설/서비스 보유여부 체크
   void   insertLodMapSer(LodRegisterDTO dto);                                     // 숙소매핑서비스테이블 저장
   void   insertLodFacility(String facility );                                     // 시설/서비스테이블 저장
   int    serviceIdxSearch(String Facitlity );                                     // 시설/서비스IDX 조회
   void   updateLodImgUrl(LodRegisterDTO dto);                                     // 숙소테이블-숙소이미지경로UPDA
   // 방 등록
   void   insertRoom(RoomRegisterDTO dto);                                         // 방테이블 저장
   void   insertPhoto(RoomRegisterDTO dto);                                        // 포토테이블
   // 성수기 페이지
   String checkPeak(SavePeakPriceDTO dto);                                        // 성수기일정관리 테이블 보유여부 체크
   void   updatePeak(SavePeakPriceDTO dto);                                       // 성수기일정관리 테이블 Update
   void   insertPeak(SavePeakPriceDTO dto);                                       // 성수기일정관리 테이블 Insert
   SavePeakPriceDTO getPeakDate(int lod_idx);                                     // 성수기일정관리 테이블 조회
   
   // 예약현황조회
   List<LodReservationDTO> sellerGetReservation(Map<String, Object> paramMap);    // 예약현황 조회

   // 리뷰조회
   Map<String, Object>      getrating(int lodIdx);                               // 리뷰 총 평점 조회
   List<SellerGetReviewDTO> sellerGetReview(int lodIdx);                         // 리뷰 현황 조회
   void updateReview(Map<String, Object> reviewMap);                             // 사장님 답글 업데이트

   // 매출관리
   Map<String, Object> getSales(int lodIdx);                                     // 사장님 매출관리
}
