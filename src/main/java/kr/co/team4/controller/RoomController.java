package kr.co.team4.controller;

import kr.co.team4.model.dto.RoomDTO;
import kr.co.team4.model.service.RoomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/room")
public class RoomController {

    @Autowired
    private RoomService roomService;

    @GetMapping("/detail")
    public String roomDetail(@RequestParam("room_idx") int roomIdx, Model model) {
        // room_idx로 객실 상세 정보 가져오기
        RoomDTO room = roomService.getRoomDetail(roomIdx);

        // 모델에 객실 정보 추가
        model.addAttribute("room", room);

        return "room/room"; // room.jsp로 이동
    }

}



