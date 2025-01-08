package kr.co.team4.model.service;

import kr.co.team4.model.dto.*;
import kr.co.team4.model.mapper.SellerPageMapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

@Service
public class SellerPageServiceImpl implements SellerPageService {
    @Autowired
    private SellerPageMapper sellerPageMapper;
    @Autowired
    private S3Service s3Service;
    @Autowired
    private HttpSession session;

    /**
     * 생성자   : JDeok
     * 기 능   : 숙소보유여부 체크
     * 변경사항
     * - 2024.12.30  : JDeok(최초생성)
     */
    @Override
    public String lodCheck(int seller_idx) {
        String checkYn = sellerPageMapper.checkLod(seller_idx);

        return checkYn;
    }

    /**
     * 생성자   : JDeok
     * 기 능   : 숙소IDX 가져오기
     * 변경사항
     * - 2024.12.31  : JDeok(최초생성)
     */
    @Override
    public int getLod(int seller_idx) {
        int lod_idx = sellerPageMapper.getLod(seller_idx);
        return lod_idx;
    }

    /**
     * 생성자   : JDeok
     * 기 능   : 숙소등록
     * 변경사항
     * - 2024.12.26 : JDeok(최초생성)
     */
    @Override
    @Transactional // 트랜잭션 적용
    /* 숙소 등록 */
    public void registerLod(LodRegisterDTO dto) {
        sellerPageMapper.insertLod(dto);

    }

    /**
     * 생성자   : JDeok
     * 기 능   : 숙소대표이미지 S3 Upload
     * 변경사항
     * - 2024.12.30 : JDeok(최초생성)
     */
    @Override
    /* 숙소이미지 등록  */
    public void registerLodImg(LodRegisterDTO dto) throws IOException {
        String fileName = dto.getLod_img().getOriginalFilename();                     // 파일명     ex) 001.png
        String FileExtension = fileName.substring(fileName.indexOf(".") + 1);    //  파일확장자 ex) png
        String imgKey = "lodgment/" + dto.getLod_idx() + "." + FileExtension;       // lodgement/IDX.png

        MultipartFile multipartFile = dto.getLod_img();
        s3Service.uploadFileToS3(imgKey, multipartFile);

        /*update를 통해 lod_img_url 변경 */
        String lod_img_url = "https://sdgb.s3.ap-northeast-2.amazonaws.com/" + imgKey;
        dto.setLod_img_url(lod_img_url);

        sellerPageMapper.updateLodImgUrl(dto);
    }

    /**
     * 생성자   : JDeok
     * 기 능   : 객실등록
     * 변경사항
     * - 2024.12.30 : JDeok(최초생성)
     */
    @Override
    @Transactional // 트랜잭션 적용
    public void registerRoom(RoomRegisterDTO roomDto) {

        System.out.println("roomDto : " + roomDto);

        roomDto.setLod_idx((int) session.getAttribute("lod_idx"));
        /* 객실 정보 insert */
        sellerPageMapper.insertRoom(roomDto);
    }

    /**
     * 생성자   : JDeok
     * 기 능   : 객실이미지 저장
     * 변경사항
     * - 2024.12.31 : JDeok(최초생성)
     */
    @Override
    public void registerRoomImg(RoomRegisterDTO roomDto) throws IOException {
        List<MultipartFile> room_photos = roomDto.getRoom_photos();

        int room_img_cnt = 0;
        for (MultipartFile room_photo : room_photos) {
            /* 객실 img insert photo table  */
            String fileName = room_photo.getOriginalFilename();                          // 파일명     ex) 001.png
            String FileExtension = fileName.substring(fileName.indexOf(".") + 1);    //  파일확장자 ex) png
            String imgKey = "Room/" +
                    roomDto.getLod_idx() +     // 숙소 IDX
                    roomDto.getRoom_idx() +     // 객실 IDX
                    room_img_cnt +     // 객실 이미지 채번
                    "." + FileExtension;         // Room/lod_idx + room_idx + 0.png

            s3Service.uploadFileToS3(imgKey, room_photo);

            /*update를 통해 room_img_url 변경 */
            String room_img_url = "https://sdgb.s3.ap-northeast-2.amazonaws.com/" + imgKey;
            roomDto.setRoom_img_url(room_img_url);

            sellerPageMapper.insertPhoto(roomDto);
            room_img_cnt++;
        }

    }

    /**
     * 생성자   : JDeok
     * 기 능   : 시설/서비스 등록
     * 변경사항
     * - 2024.12.26 : JDeok(최초생성)
     */
    @Override
    @Transactional // 트랜잭션 적용 자동롤백
    /* 시설/서비스 등록 */
    public void registerFacility(LodRegisterDTO dto) {
        /* 시설/서비스 체크 후 insert */
        List<String> facilities = dto.getLod_facility();

        if (facilities != null && facilities.isEmpty() == false) {
            for (String facility : facilities) {
                try {
                    String checkYn = sellerPageMapper.checktFacility(facility);

                    /* 시설/서비스  테이블에 같은 시설/서비스 명이 있는 경우            */
                    /* 1. 숙소매핑서비스테이블(LOGMENT_MAPPING_SERVICE)에 INSERT함  */
                    if ("Y".equals(checkYn)) {
                        int service_idx = sellerPageMapper.serviceIdxSearch(facility);
                        dto.setLod_facility_idx(service_idx);
                        sellerPageMapper.insertLodMapSer(dto);
                    }
                    /* 시설/서비스 테이블에 같은 시설/서비스 명이 없는 경우             */
                    /* 1. 시설/서비스테이블에 INSERT 함                            */
                    /* 2. 숙소매핑서비스테이블(LOGMENT_MAPPING_SERVICE)에 INSERT함  */
                    else if ("N".equals(checkYn)) {
                        sellerPageMapper.insertLodFacility(facility);
                        int service_idx = sellerPageMapper.serviceIdxSearch(facility);
                        dto.setLod_facility_idx(service_idx);
                        sellerPageMapper.insertLodMapSer(dto);
                    } else {
                        System.out.println(checkYn);
                    }
                } catch (Exception e) {
                    // 예외 처리
                    System.err.println("시설/서비스 처리 중 오류 발생(lodRegisterServiceImpl.java): " + facility);
                    e.printStackTrace(); // 상세 예외 출력 (로그 시스템을 활용하는 것을 권장)
                }

            }
        }
    }

    /**
     * 생성자   : JDeok
     * 기 능   : 시설/서비스 등록
     * 변경사항
     * - 2024.12.26 : JDeok(최초생성)
     */
    @Transactional // 트랜잭션 적용 자동롤백
    @Override
    public void savePeekPrice(SavePeakPriceDTO dto) {
        String checkYn = sellerPageMapper.checkPeak(dto);

        if ("Y".equals(checkYn)) {
            /* 보유 중이라면 일자 UPDATE*/
            sellerPageMapper.updatePeak(dto);
        } else if ("N".equals(checkYn)) {
            /* 보유 중이 아니라면 새로 INSERT*/
            sellerPageMapper.insertPeak(dto);
        }
    }

    /**
     * 생성자   : JDeok
     * 기 능   :  성수기 일자 조회
     * 변경사항
     * - 2025.01.02 : JDeok(최초생성)
     *
     * @return
     */
    @Override
    public SavePeakPriceDTO getPeakDate(int lodIdx) {

        return sellerPageMapper.getPeakDate(lodIdx);
    }

    /**
     * 생성자   : JDeok
     * 기 능   :  예약현황 조회
     * 변경사항
     * - 2025.01.03 : JDeok(최초생성)
     */
    @Override
    public List<LodReservationDTO> sellerGetReservation(Map<String, Object> paramMap) {
        return sellerPageMapper.sellerGetReservation(paramMap);
    }

    /**
     * 생성자   : JDeok
     * 기 능   : 리뷰 평점
     * 변경사항
     * - 2025.01.03 : JDeok(최초생성)
     */
    @Override
    public Map<String, Object> getrating(int lod_idx) {

        return sellerPageMapper.getrating(lod_idx);
    }

    /**
     * 생성자   : JDeok
     * 기 능   : 리뷰 데이터
     * 변경사항
     * - 2025.01.03 : JDeok(최초생성)
     */
    @Override
    public List<SellerGetReviewDTO> getReview(int lod_idx) {
        return sellerPageMapper.sellerGetReview(lod_idx);
    }

    /**
     * 생성자   : JDeok
     * 기 능   : 리뷰 사장님 답글 업데이트
     * 변경사항
     * - 2025.01.03 : JDeok(최초생성)
     */
    @Override
    public void updateReview(Map<String, Object> reviewMap) {
        sellerPageMapper.updateReview(reviewMap);
    }

    /**
     * 생성자   : JDeok
     * 기 능   : 매출관리
     * 변경사항
     * - 2025.01.03 : JDeok(최초생성)
     */
    @Override
    public Map<String, Object> getSales(int lodIdx) {
        Map<String, Object> salesData = sellerPageMapper.getSales(lodIdx);

        List<String> month_date = new ArrayList<>(Arrays.asList(
                (String) salesData.get("min6_month_date"),          // 6개월 전 달
                (String) salesData.get("min5_month_date"),          // 5개월 전 달
                (String) salesData.get("min4_month_date"),          // 4개월 전 달
                (String) salesData.get("min3_month_date"),          // 3개월 전 달
                (String) salesData.get("min2_month_date"),          // 2개월 전 달
                (String) salesData.get("min1_month_date"),          // 1개월 전 달
                (String) salesData.get("current_month")             // 이번달
        ));

        ArrayList<BigDecimal> total_money = new ArrayList<>(Arrays.asList(
                (BigDecimal) salesData.get("min6_month_money"),        // 6개월 전 합산금액
                (BigDecimal) salesData.get("min5_month_money"),        // 5개월 전 합산금액
                (BigDecimal) salesData.get("min4_month_money"),        // 4개월 전 합산금액
                (BigDecimal) salesData.get("min3_month_money"),        // 3개월 전 합산금액
                (BigDecimal) salesData.get("min2_month_money"),        // 2개월 전 합산금액
                (BigDecimal) salesData.get("min1_month_money"),        // 1개월 전 합산금액
                (BigDecimal) salesData.get("month_money")              // 이번 달 합산금액
        ));

        salesData.put("month_date", month_date);
        salesData.put("total_money", total_money);

        return salesData;
    }

    /**
     * 생성자   : JDeok
     * 기 능   : 숙소정보 가져오기
     * 변경사항
     * - 2025.01.06 : JDeok(최초생성)
     */
    @Override
    public Map<String, Object> getLodInformation(int lod_idx) {
        return sellerPageMapper.getLodInformation(lod_idx);
    }

    /**
     * 생성자   : JDeok
     * 기 능   : 시설/서비스 가져오기
     * 변경사항
     * - 2025.01.06 : JDeok(최초생성)
     */
    @Override
    public List<String> getLodService(int lod_idx) {
        return sellerPageMapper.getLodService(lod_idx);
    }

    /**
     * 생성자   : JDeok
     * 기 능   : 변경된 숙소정보 Update
     * 변경사항
     * - 2025.01.06 : JDeok(최초생성)
     */
    @Override
    public void UpdateLod(LodRegisterDTO dto) {
        sellerPageMapper.UpdateLod(dto);
    }
    /**
     * 생성자   : JDeok
     * 기 능   : 변경된 시설/서비스 Update
     * 변경사항
     * - 2025.01.06 : JDeok(최초생성)
     */
    @Override
    public void UpdateFacility(LodRegisterDTO dto) {

        List<String> facilities = dto.getLod_facility();
        /* 매핑테이블 전부 삭제 후 insert */
        sellerPageMapper.deleteLodMapper(dto.getLod_idx());

        if (facilities != null && !facilities.isEmpty()) {
            for (String facility : facilities) {
                try{
                    String checkYn = sellerPageMapper.checktFacility(facility);



                    if("Y".equals(checkYn)) {
                        /*  시설/서비스가 기존에 있는 데이터라면 mapper테이블만 insert */
                        int service_idx = sellerPageMapper.serviceIdxSearch(facility);
                        dto.setLod_facility_idx(service_idx);
                        sellerPageMapper.insertLodMapSer(dto);
                    }else if("N".equals(checkYn)) {
                        /*  시설/서비스가 신규라면 새로 insert 후 mapper테이블도 inser */
                        sellerPageMapper.insertLodFacility(facility);
                        int service_idx = sellerPageMapper.serviceIdxSearch(facility);
                        dto.setLod_facility_idx(service_idx);
                        sellerPageMapper.insertLodMapSer(dto);
                    }else{

                    }
                }catch (Exception e){

                }
            }
        }
    }

    /**
     * 생성자   : JDeok
     * 기 능   : 방정보 가져오기
     * 변경사항
     * - 2025.01.08 : JDeok(최초생성)
     */
    @Override
    public List<RoomRegisterDTO> getRoomInformation(int lod_idx) {

        return sellerPageMapper.getRoomInformation(lod_idx);
    }

    /**
     * 생성자   : JDeok
     * 기 능   : 방 정보 update
     * 변경사항
     * - 2025.01.08 : JDeok(최초생성)
     */
    @Override
    public void updateRoom(List<RoomRegisterDTO> rooms) {

        for(RoomRegisterDTO dto : rooms) {
            if(dto.getRoom_idx() != null){
                sellerPageMapper.updateRoom(dto);
            }
        }

    }
}
