package kr.co.team4.model.mapper;

import kr.co.team4.model.dto.LodRegisterDTO;
import kr.co.team4.model.dto.RoomRegisterDTO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SellerPageMapper {

   //사장님 페이지
   String checkLod(int seller_idx);                       // 숙소존재여부 체크
   int    getLod  (int seller_idx);                       // 숙소IDX 가져오기

   //숙소등록
   void   insertLod(LodRegisterDTO dto);                  // 숙소테이블  저장
   String checktFacility(String Facitlity);               // 시설/서비스 존재여부 체크
   void   insertLodMapSer(LodRegisterDTO dto);            // 숙소매핑서비스테이블 저장
   void   insertLodFacility(String facility );            // 시설/서비스테이블 저장
   int    serviceIdxSearch(String Facitlity );            // 시설/서비스IDX 조회
   void   updateLodImgUrl(LodRegisterDTO dto);            // 숙소테이블-숙소이미지경로UPDATE

   // 방 등록
   void   insertRoom(RoomRegisterDTO dto);                // 방테이블 저장
   void   insertPhoto(RoomRegisterDTO dto);               // 포토테이블 저장
}
