package kr.co.team4.controller;

import kr.co.team4.model.dto.*;
import kr.co.team4.model.service.LodFacilityService;
import kr.co.team4.model.service.LodgmentService;
import kr.co.team4.model.service.LodReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class LodgmentController {

    @Autowired
    private LodgmentService lodgmentService;

    @Autowired
    private LodReviewService lodReviewService; // LodReviewService 추가

    @Autowired
    private LodFacilityService lodFacilityService; // LodFacilityService 추가

    @GetMapping("/lodgment.do")
    public String index(Model model) {
        LodgmentDTO lodgmentDTO = new LodgmentDTO();
        lodgmentDTO.setLod_idx(3); // 테스트용

        // 숙소 상세 정보 가져오기
        model.addAttribute("lodgment", lodgmentService.lodgmentDetail(lodgmentDTO));

        // 숙소에 연결된 객실 리스트 가져오기
        List<RoomDTO> roomList = lodgmentService.getRoomsByLodgment(lodgmentDTO.getLod_idx());
        model.addAttribute("roomList", roomList);

        // 판매자 정보 가져오기
        SellerDTO sellerInfo = lodgmentService.getSellerInfo(lodgmentDTO.getLod_idx());
        model.addAttribute("sellerInfo", sellerInfo);

        // 리뷰 통계 가져오기
        Map<String, Object> statistics = lodReviewService.getReviewStatistics(lodgmentDTO.getLod_idx());
        model.addAttribute("statistics", statistics);

        // 리뷰 목록 가져오기
        List<LodReviewDTO> reviewList = lodReviewService.getReviewList(lodgmentDTO.getLod_idx());
        model.addAttribute("reviewList", reviewList);

        // 시설/서비스 리스트 가져오기
        List<LodFacilityDTO> facilityList = lodFacilityService.getFacilityList(lodgmentDTO.getLod_idx());
        System.out.println("시설 리스트: " + facilityList);
        model.addAttribute("facilityList", facilityList);

        return "lodgment/lodgment"; // "lodgment" 페이지로 이동
    }

    @PostMapping("/lodgment/availableRooms.do")
    @ResponseBody
    public List<RoomDTO> getAvailableRooms(@RequestParam(value = "checkinDate", required = false) String checkinDate,
                                           @RequestParam(value = "checkoutDate", required = false) String checkoutDate,
                                           @RequestParam(value = "guestCount", required = false, defaultValue = "2") int guestCount,
                                           @RequestParam(value = "petCount", required = false, defaultValue = "1") int petCount) {
        Map<String, Object> params = new HashMap<>();
        params.put("checkinDate", checkinDate);
        params.put("checkoutDate", checkoutDate);
        params.put("guestCount", guestCount);
        params.put("petCount", petCount);

        // Service를 호출하여 예약 가능한 객실 리스트를 가져옴
        return lodgmentService.getAvailableRooms(params);
    }
}