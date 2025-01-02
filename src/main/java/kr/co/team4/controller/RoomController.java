package kr.co.team4.controller;

import kr.co.team4.model.dto.RoomDTO;
import kr.co.team4.model.service.RoomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDate;

@Controller
@RequestMapping("/room")
public class RoomController {

    @Autowired
    private RoomService roomService;

    @GetMapping("/detail")
    public String roomDetail(@RequestParam("room_idx") int room_idx,
                             @RequestParam(value = "checkinDate", required = false) String checkinDate,
                             @RequestParam(value = "checkoutDate", required = false) String checkoutDate,
                             @RequestParam(value = "guestCount", required = false) int guestCount,
                             @RequestParam(value = "petCount", required = false) int petCount,
                             Model model) {
        // room_idx로 객실 상세 정보 가져오기
        RoomDTO room = roomService.getRoomDetail(room_idx);

        // 기본값 설정 (오늘 날짜와 내일 날짜)
        if (checkinDate == null || checkoutDate == null) {
            LocalDate today = LocalDate.now();
            checkinDate = today.toString();
            checkoutDate = today.plusDays(1).toString();
        }


        // 모델에 객실 정보 추가
        model.addAttribute("room", room);
        model.addAttribute("checkinDate", checkinDate);
        model.addAttribute("checkoutDate", checkoutDate);
        model.addAttribute("guestCount", guestCount);
        model.addAttribute("petCount", petCount);

        return "room/room"; // room.jsp로 이동
    }

}



