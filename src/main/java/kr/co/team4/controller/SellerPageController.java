package kr.co.team4.controller;

import kr.co.team4.model.dto.*;
import kr.co.team4.model.service.SellerPageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Pattern;

@Controller
@RequestMapping("/lodgment")
public class SellerPageController {
    /**
     * 생성자   : JDeok
     * 기 능   : 사장님 숙소등록 로직
     * 변경사항
     * - 2024.12.26 : JDeok(최초생성)
     */
    @Autowired //[check]
    private SellerPageService sellerPageService;

    @PostMapping("/insertLod.do")
    public String lodRegister(@ModelAttribute LodRegisterDTO dto, HttpSession session) throws IOException {

        dto.setSeller_idx((int) session.getAttribute("seller_idx"));

        sellerPageService.registerLod(dto);

        /* Amazon S3 이미지 적용 */
        sellerPageService.registerLodImg(dto);

        sellerPageService.registerFacility(dto);

        //session에 lod_idx 저장(객실등록 시 사용)
        session.setAttribute("lod_idx", dto.getLod_idx());
        return "redirect:/lodgment/sellerDetailMain";
    }

    /**
     * 생성자   : JDeok
     * 기 능   : 객실등록
     * 변경사항
     * - 2024.12.30 : JDeok(최초생성)
     */
    @PostMapping("/insertRoom")
    public String insertRoom(@ModelAttribute RoomListDTO roomListDto, HttpSession session) throws IOException {
        List<RoomRegisterDTO> rooms = roomListDto.getRooms();
        // 각 객실 정보 처리
        for (RoomRegisterDTO roomDto : rooms) {
            //객실 예약
            sellerPageService.registerRoom(roomDto);

            // 객실 이미지 저장
            sellerPageService.registerRoomImg(roomDto);
        }

        return "redirect:/lodgment/roomRegister";
    }

    /**
     * 생성자   : JDeok
     * 기 능   : 사장님 상세페이지 조회
     * 변경사항
     * - 2024.12.24 : JDeok(최초생성)
     */
    @GetMapping("/sellerDetailMain")
    public String sellerDetailMain(Model model) {
        model.addAttribute("pageTitle", "sellerDetailMain"); // 활성 메뉴 설정
        return "seller/sellerDetailMain";
    }

    /**
     * 생성자   : JDeok
     * 기 능   : 사장님 메인페이지 조회
     * 변경사항
     * - 2024.12.23 : JDeok(최초생성)
     */
    @GetMapping("/sellerMain.do")
    public String sellerMain() {
        /**
         * [check] 로그인상태인지 확인
         * 로그인 상태이면 들어올 필요 X
         */
        return "seller/sellerMain";
    }

    /**
     * 생성자   : JDeok
     * 기 능   : 사장님 숙소등록페이지 조회
     * 변경사항
     * - 2024.12.23 : JDeok(최초생성)
     */
    @GetMapping("/lodRegister.do")
    public String lodRegister(HttpSession session) {

        /*session.setAttribute("seller_idx", 2);*/
        SellerDTO seller = (SellerDTO) session.getAttribute("sellersession");
        int seller_idx = seller.getSELLER_IDX().intValue();
        session.setAttribute("seller_idx", seller_idx);
        /* 여기서 숙소테이블에 존재 여부 확인 후 if else로 나눠서 없으면 숙소등록 아니면 바로 숙소메인페이지 */
        String checkYn = sellerPageService.lodCheck(seller_idx);

        if ("Y".equals(checkYn)) {
            session.setAttribute("lod_idx", sellerPageService.getLod(seller_idx));
            return "seller/sellerDetailMain";
        } else if ("N".equals(checkYn)) {
            return "seller/lodRegister";
        } else {
            return "seller/sellerMain";
        }
    }

    /**
     * 생성자   : JDeok
     * 기 능   : 사장님 객실등록
     * 변경사항
     * - 2024.12.24 : JDeok(최초생성)
     */
    @GetMapping("/roomRegister")
    public String roomRegister(HttpSession session) {
        int lod_idx = (int)session.getAttribute("lod_idx");

        /*sellerPageService.getRoomInformation(lod_idx);*/

        return "seller/roomRegister";
    }

    /**
     * 생성자   : JDeok
     * 기 능   : 성수기 가격일자 저장
     * 변경사항
     * - 2024.12.24 : JDeok(최초생성)
     */
    @PostMapping("/savePeakPrice")
    public String savePeakPrice(@ModelAttribute SavePeakPriceDTO dto, HttpSession session) {
        dto.setLod_idx((int) session.getAttribute("lod_idx"));
        sellerPageService.savePeekPrice(dto);
        return "seller/sellerDetailMain";
    }

    /**
     * 생성자   : JDeok
     * 기 능   : 사장님 메인화면 달력에 성수기 일정 출력
     * 변경사항
     * - 2024.12.24 : JDeok(최초생성)
     */
    @GetMapping("/getPeakPriceEvents.do")
    @ResponseBody // JSON 형식으로 응답을 보냄
    public List<Map<String, Object>> getPeakPriceEvents(HttpSession session, Model model) {
        SavePeakPriceDTO dto = sellerPageService.getPeakDate((int) session.getAttribute("lod_idx"));

        List<Map<String, Object>> events = new ArrayList<>();
        if (dto != null) {
            // 성수기 일정
            if (dto.getPeak_str_dt() != null && dto.getPeak_end_dt() != null) {
                Map<String, Object> peakEvent = new HashMap<>();
                peakEvent.put("title", "성수기");
                peakEvent.put("start", dto.getPeak_str_dt());
                peakEvent.put("end", dto.getPeak_end_dt());
                peakEvent.put("color", "#8A5642");
                events.add(peakEvent);
            }

            // 극성수기 일정
            if (dto.getHpeak_str_dt() != null && dto.getHpeak_end_dt() != null) {
                Map<String, Object> highPeakEvent = new HashMap<>();
                highPeakEvent.put("title", "극성수기");
                highPeakEvent.put("start", dto.getHpeak_str_dt());
                highPeakEvent.put("end", dto.getHpeak_end_dt());
                highPeakEvent.put("color", "#DDAC7E");
                events.add(highPeakEvent);
            }
        }

        model.addAttribute("dto", dto);
        return events; // JSON 형식으로 반환
    }

    /**
     * 생성자   : JDeok
     * 기 능   : 성수기 가격 관리
     * 변경사항
     * - 2024.12.24 : JDeok(최초생성)
     */
    @GetMapping("/sellerPeakPrice")
    public String sellerPeakPrice(HttpSession session) {

        return "seller/sellerPeakPrice";

    }

    /**
     * 생성자   : JDeok
     * 기 능   : 사장님 성수기기간 조회
     * 변경사항
     * - 2024.12.24 : JDeok(최초생성)
     */
    @GetMapping("/sellerPeakInq")
    public String sellerPeakInq(HttpSession session, Model model) {

        SavePeakPriceDTO dto = sellerPageService.getPeakDate((int) session.getAttribute("lod_idx"));
        model.addAttribute("dto", dto);

        return "seller/sellerPeakPrice";
    }

    /**
     * 생성자   : JDeok
     * 기능    : 예약현황 조회
     */
    @GetMapping("/sellerGetReservation")
    public String sellerGetReservation(
            @RequestParam(value = "dateRange", required = false) String dateRange,
            @RequestParam(value = "ajax", required = false, defaultValue = "false") boolean ajax,
            HttpSession session, Model model) {
        Integer lod_idx = (int) session.getAttribute("lod_idx");

        // 날짜 범위를 파싱
        String[] dates   = dateRange != null ? dateRange.split(" ~ ") : new String[0];
        String startDate = dates.length > 0 ? dates[0] : null;
        String endDate   = dates.length > 1 ? dates[1] : null;

        // 파라미터를 Map으로 생성
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("lod_idx"   , lod_idx);
        paramMap.put("startDate", startDate);
        paramMap.put("endDate"  , endDate);

        List<LodReservationDTO> reservations = sellerPageService.sellerGetReservation(paramMap);

        // 날짜 형식 변환
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat dateTimeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy년 MM월 dd일 a hh시 mm분");
        SimpleDateFormat periodFormat = new SimpleDateFormat("yyyy년 MM월 dd일(E)");

        for (LodReservationDTO reservation : reservations) {
            try {
                // 예약 일자 변환
                if (reservation.getCreated() != null) {
                    Date createdDate;
                    if (reservation.getCreated().length() > 10) {
                        createdDate = dateTimeFormat.parse(reservation.getCreated());
                    } else {
                        createdDate = dateFormat.parse(reservation.getCreated());
                    }
                    reservation.setCreated(outputFormat.format(createdDate));
                }

                // 예약 기간 변환
                if (reservation.getRes_str_date() != null && reservation.getRes_end_date() != null) {
                    Date startPeriod = dateFormat.parse(reservation.getRes_str_date());
                    Date endPeriod = dateFormat.parse(reservation.getRes_end_date());
                    String startFormatted = periodFormat.format(startPeriod);
                    String endFormatted = periodFormat.format(endPeriod);
                    reservation.setRes_str_date(startFormatted);
                    reservation.setRes_end_date(endFormatted);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        // 응답 데이터 생성
        model.addAttribute("reservations", reservations);

        if (ajax) {
            return "seller/sellerReservationList";
        }
        return "seller/sellerShowReservation";
    }

    /**
     * 생성자   : JDeok
     * 기 능   : 리뷰 조회
     * 변경사항
     * - 2024.12.24 : JDeok(최초생성)
     */
    @GetMapping("/sellerGetReview")
    public String sellerGetReview(HttpSession session, Model model) {

        int lod_idx = (int) session.getAttribute("lod_idx");

        Map<String, Object> review = sellerPageService.getrating(lod_idx);

        model.addAttribute("review", review);

        List<SellerGetReviewDTO> dto = sellerPageService.getReview(lod_idx);
        model.addAttribute("reviews", dto);
        return "seller/sellerShowReview";
    }
    /**
     * 생성자   : JDeok
     * 기 능   : 리뷰 조회
     * 변경사항
     * - 2024.12.24 : JDeok(최초생성)
     */
    @PostMapping("/sellerReviewList")
    public String addReply(@RequestBody Map<String, Object> requestBody, HttpSession session, Model model) {

        int lod_idx = (int) session.getAttribute("lod_idx");

        Map<String, Object> reviewMap = new HashMap<>();
        reviewMap.put("review_idx", (int)requestBody.get("review_idx"));
        reviewMap.put("replycontent", (String)requestBody.get("replycontent"));
        sellerPageService.updateReview(reviewMap);

        List<SellerGetReviewDTO> dto = sellerPageService.getReview(lod_idx);
        model.addAttribute("reviews", dto);

        return "seller/sellerReviewList";
    }

    /**
     * 생성자   : JDeok
     * 기 능   : 사장님 매출관리
     * 변경사항
     * - 2024.12.24 : JDeok(최초생성)
     */
    @GetMapping("/sellerGetSales")
    public String getSalesManagement(Model model, HttpSession session) {
        int lod_idx = (int) session.getAttribute("lod_idx");

        Map<String, Object> salesMap = sellerPageService.getSales(lod_idx);

        model.addAttribute("month_date" , salesMap.get("month_date" ));   // 월 날짜
        model.addAttribute("total_money", salesMap.get("total_money"));   // 매출 금액

        return "seller/sellerSales";
    }

    /**
     * 생성자   : JDeok
     * 기 능   : 숙소 정보 수정
     * 변경사항
     * - 2024.12.24 : JDeok(최초생성)
     */
    @GetMapping("/sellerGetLodUpdate")
    public String sellerGetLodUpdate(Model model, HttpSession session) {
        int lod_idx = (int) session.getAttribute("lod_idx");

       /* 숙소 데이터 가져오기 */
        Map<String, Object> lodMap = sellerPageService.getLodInformation(lod_idx);
       /* 시설/서비스 가져오기 */
        List<String> service = sellerPageService.getLodService(lod_idx);


        model.addAttribute("lodMap", lodMap);
        model.addAttribute("service", service);

       return "seller/sellerLodUpdate";
    }

    /**
     * 생성자   : JDeok
     * 기 능   : 숙소 업데이트
     * 변경사항
     * - 2025.01.06 : JDeok(최초생성)
     */
    @PostMapping("/UpdateLod")
    @Transactional // 트랜잭션 적용
    public String UpdateLod(@ModelAttribute LodRegisterDTO dto, HttpSession session, Model model) throws IOException {
        try {
            int lod_idx = (int) session.getAttribute("lod_idx");
            dto.setLod_idx(lod_idx);

            // 숙소 업데이트 로직
            sellerPageService.UpdateLod(dto);

            // 시설/서비스 업데이트 로직
            sellerPageService.UpdateFacility(dto);

            // 성공 상태를 Model에 추가
            model.addAttribute("success", true);
        } catch (Exception e) {
            e.printStackTrace(); // 로그 출력
            // 실패 상태를 Model에 추가
            model.addAttribute("success", false);
            model.addAttribute("errorMessage", "처리 중 오류가 발생했습니다.");
        }


        return "seller/sellerLodUpdate";
    }

    /**
     * 생성자   : JDeok
     * 기 능   : 사장님 객실정보
     * 변경사항
     * - 2025.01.07 : JDeok(최초생성)
     */
    @GetMapping("/sellerGetRoomUpdate")
    public String sellerGetRoomUpdate(Model model, HttpSession session) {
        int lod_idx = (int) session.getAttribute("lod_idx");

        List<RoomRegisterDTO> roomList  = sellerPageService.getRoomInformation(lod_idx);


        model.addAttribute("roomList", roomList);

        return "seller/sellerRoomUpdate";
    }

    /**
     * 생성자   : JDeok
     * 기 능   : 사장님 객실정보
     * 변경사항
     * - 2025.01.07 : JDeok(최초생성)
     */
    @PostMapping("/updateRoom")
    public String UpdateLod(@ModelAttribute RoomListDTO dto, HttpSession session, Model model) {
        List<RoomRegisterDTO> rooms = dto.getRooms();

        try {
            sellerPageService.updateRoom(rooms);

            // 성공 상태를 Model에 추가
            model.addAttribute("success", true);
        }catch (Exception e){

            model.addAttribute("success", false);
            model.addAttribute("errorMessage", "처리 중 오류가 발생했습니다.");
        }


        return "seller/sellerRoomUpdate";
    }

}