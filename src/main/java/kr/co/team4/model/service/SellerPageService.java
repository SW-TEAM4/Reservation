package kr.co.team4.model.service;

import kr.co.team4.model.dto.*;

import java.io.IOException;
import java.util.List;
import java.util.Map;

public interface SellerPageService {

    /* 사장님페이지 메인 */
    String lodCheck(int seller_idx);                                                              // 숙소보유여부 체크
    int    getLod  (int seller_idx);                                                              // 숙소IDX 가져오기

    /* 숙소 등록 */
    void   registerLod     (LodRegisterDTO dto);                                     // 숙소 등록
    void   registerFacility(LodRegisterDTO dto);                                     // 시설/서비스 등록
    void   registerLodImg  (LodRegisterDTO dto) throws IOException;                  // Amazon S3 이미지 등록

    /* 객실 등록 */
    void   registerRoom(RoomRegisterDTO roomDto);                                    // 객실등록
    void   registerRoomImg(RoomRegisterDTO dto) throws IOException;                  // 객실 이미지 등록

    /*성수기 페이지*/
    void             savePeekPrice(SavePeakPriceDTO dto);                            // 성수기 일정등록
    SavePeakPriceDTO getPeakDate(int lodIdx);                                        // 성수기 일정 조회

    /* 예약현황 조회 */
    List<LodReservationDTO> sellerGetReservation(Map<String, Object> paramMap);      // 예약현황 조회

    /* 리뷰 조회 */
    Map<String, Object>      getrating(int lodIdx);                                   // 평균평점, 평가 수 조회
    List<SellerGetReviewDTO> getReview(int lod_idx);                                  // 리뷰 조회
    void                     updateReview(Map<String, Object> reviewMap);             // 사장님 답글 업데이트

    /* 매출 관리 */
    Map<String, Object> getSales(int lodIdx);                                         // 사장님 매출관리

    /* 숙소정보 수정  */
    Map<String, Object>       getLodInformation(int lodIdx);                          // 숙소정보 조회
    List<String>              getLodService(int lodIdx);                              // 숙소서비스 조회
    void                      UpdateLod(LodRegisterDTO dto);                          // 숙소정보 수정
    void                      UpdateFacility(LodRegisterDTO dto);                     // 시설/서비스 수정

    /* 객실정보 조회및변경 */
    List<RoomRegisterDTO> getRoomInformation(int lodIdx);                              // 객실정보 조회
    void updateRoom(List<RoomRegisterDTO> rooms);                                      // 객실 수정

    // 숙소명 조회
    String getLodgmentName(int lod_idx);                                               // 숙소명 조회
}
