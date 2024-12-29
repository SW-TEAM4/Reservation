package kr.co.team4.controller;

import kr.co.team4.model.dto.LodgmentDTO;
import kr.co.team4.model.dto.RoomDTO;
import kr.co.team4.model.dto.SellerDTO;
import kr.co.team4.model.service.LodgmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;


@Controller
public class LodgmentController {
    @Autowired
    private LodgmentService lodgmentService;

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

        return "lodgment"; // "lodgment" 페이지로 이동
    }
    }



