package kr.co.team4.model.service;

import kr.co.team4.model.dto.lodRegisterDTO;
import kr.co.team4.model.mapper.lodRegisterMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class lodRegisterServiceImpl implements lodRegisterService {
    @Autowired
    private lodRegisterMapper lodRegisterMapper;

    @Override
    public void registerLod(lodRegisterDTO dto) {
        lodRegisterMapper.insertLod(dto);

    }

    @Override
    public void registerFacility(lodRegisterDTO dto) {
        /* 시설/서비스 체크 후 insert */
        List<String> facilities = dto.getLod_facility();

        if(facilities != null && facilities.isEmpty() == false){
            for(String facility : facilities){
                try{
                    String check = lodRegisterMapper.checktFacility(facility);
                    /* 시설/서비스  테이블에 같은 시설/서비스 명이 있는 경우
                     * 숙소매핑서비스테이블(LOGMENT_MAPPING_SERVICE)에 INSERT함
                     * */
                    if(check == "Y"){

                    }
                    /* 시설/서비스 테이블에 같은 시설/서비스 명이 없는 경우
                     *  1. 시설/서비스테이블에 INSERT 함
                     *  2. 숙소매핑서비스테이블(LOGMENT_MAPPING_SERVICE)에 INSERT함*/
                    else if(check == "N"){

                    }
                    System.out.println(check);
                }catch (Exception e){
                    // 예외 처리
                    System.err.println("시설/서비스 처리 중 오류 발생(lodRegisterServiceImpl.java): " + facility);
                    e.printStackTrace(); // 상세 예외 출력 (로그 시스템을 활용하는 것을 권장)
                }

            }
        }
    }
}
