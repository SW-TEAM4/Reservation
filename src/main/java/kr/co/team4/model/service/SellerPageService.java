package kr.co.team4.model.service;

import kr.co.team4.model.dto.LodRegisterDTO;
import kr.co.team4.model.dto.RoomRegisterDTO;

import java.io.IOException;
import java.util.List;

public interface SellerPageService {

    /* 사장님페이지 메인 */
    String lodCheck(int seller_idx);                                         // 숙소보유여부 체크
    int    getLod  (int seller_idx);                                         // 숙소IDX 가져오기

    /* 숙소 등록 */
    void   registerLod     (LodRegisterDTO dto);                             // 숙소 등록
    void   registerFacility(LodRegisterDTO dto);                             // 시설/서비스 등록
    void   registerLodImg  (LodRegisterDTO dto) throws IOException;          // Amazon S3 이미지 등록

    /* 객실 등록 */
    void   registerRoom(RoomRegisterDTO roomDto);                            // 객실등록
    void   registerRoomImg(RoomRegisterDTO dto) throws IOException;          // 객실 이미지 등록
}
