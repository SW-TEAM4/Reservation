package kr.co.team4.controller;

import kr.co.team4.model.dto.*;
import kr.co.team4.model.service.SellerPageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
        dto.setLod_img_url("");

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
        session.setAttribute("seller_idx", 10);
        int seller_idx = (int) session.getAttribute("seller_idx");
        /*[check] 여기서 숙소테이블에 존재 여부 확인 후 if else로 나눠서 없으면 숙소등록 아니면 바로 숙소메인페이지 */
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
     * 기 능   : 사장님 상세페이지 조회
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
     * 기 능   : 사장님 상세페이지 조회
     * 변경사항
     * - 2024.12.24 : JDeok(최초생성)
     */
    @GetMapping("/sellerGetReservation")
    public String sellerGetReservation(HttpSession session, Model model) {

        SavePeakPriceDTO dto = sellerPageService.getPeakDate((int) session.getAttribute("lod_idx"));
        model.addAttribute("dto", dto);

        return "seller/sellerShowReservation";
    }
}

