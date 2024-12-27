package kr.co.team4.model.mapper;

import kr.co.team4.model.dto.lodRegisterDTO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface lodRegisterMapper {
   void insertLod(lodRegisterDTO dto);                // 숙소테이블  저장
   String checktFacility(String Facitlity);           // 시설/서비스 존재여부 체크
}
