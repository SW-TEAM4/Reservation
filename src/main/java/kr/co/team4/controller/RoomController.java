package kr.co.team4.controller;

import kr.co.team4.model.dto.RoomDTO;
import kr.co.team4.model.service.RoomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;


//@Controller
//@RequestMapping("/rooms")
//public class RoomController {
//
//    @Autowired
//    private RoomService roomService;
//
//    @GetMapping("/room.do")
//    public String index(Model model,
//                        RoomDTO roomDTO,
//                        @RequestParam(required = false, defaultValue = "2") int peopleCount,
//                        @RequestParam(required = false, defaultValue = "1") int dogCount,
//                        @RequestParam(required = false) String roomReservationStartDate,
//                        @RequestParam(required = false) String roomReservationEndDate) {
//
//        // 예약 가능한 방 리스트 필터링을 위한 파라미터 설정
//        Map<String, Object> params = new HashMap<>();
//        params.put("lod_idx", roomDTO.getLod_idx());
//        params.put("room_reservation_start_date", roomReservationStartDate);
//        params.put("room_reservation_end_date", roomReservationEndDate);
//        params.put("people_count", peopleCount);
//        params.put("dog_count", dogCount);
//
//        // 예약 가능한 방을 조회
//        model.addAttribute("availableRooms", roomService.availableRooms(params));
//        return "room";
//    }
//}
@Controller
public class RoomController {
    @GetMapping("/room.do")
    public String index() {
        return "room";
    }
}
