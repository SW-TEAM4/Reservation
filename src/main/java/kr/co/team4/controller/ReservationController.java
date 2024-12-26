package kr.co.team4.controller;

import kr.co.team4.model.dto.ReservationDTO;
import kr.co.team4.model.dto.RoomDTO;
import kr.co.team4.model.service.ReservationService;
import kr.co.team4.model.service.RoomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.Date;

@Controller
public class ReservationController {
    /*
    * 예약 페이지 관련 컨트롤러 클래스
    *
    * type: Post
    * method: reserveAdd()
    * 기능: 예약 정보를 reservation table에 저장
    * 예약이 가능하다면 reservation table에 저장 후 결제 페이지 이동,
    * 예약 불가능하면 이전 페이지로 이동
    */
    @Autowired
    private ReservationService reservationService;
    @Autowired
    private RoomService roomService;

    @GetMapping("/reserve/reservationtest.do")
    public String index(){
        return "reserveation";
    }

    // 날짜 형식 설정 (yyyy-MM-dd'T'HH:mm)
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }

    @PostMapping("/reserve/saveReservation.do")
    public void saveReserve(Model model, @RequestParam("res_status") String status, ReservationDTO reservationDTO){
        reservationDTO.setStatus(status);
        if(reservationService.reserveAdd(reservationDTO)){
            // db에 예약 정보 성공적으로 저장 후 model에 예약 정보와, 실제 users의 정보 저장
            model.addAttribute("reserveDTO", reservationDTO);
            model.addAttribute("user", reservationService.getUserInform(reservationDTO));
        }
    }

    // room_idx를 이용해 방정보를 가져오고 이를 이용한 예약 화면 화면 출력
    @GetMapping("/reserve/reservation.do")
    public String goReservtion(Model model, @RequestParam("room_idx") int room_idx){
        model.addAttribute("roomDTO", roomService.getRoomDetail(room_idx));
        return "reserve/reservation";
    }


    @PostMapping("/reserve/reservation.do")
    public String goPayment(Model model,@ModelAttribute ReservationDTO reservationDTO){
        if(reservationService.reserveAdd(reservationDTO)){
            // Todo 결제창에서 필요한 데이터 추가
            //model.add
            return "payment/payment";
        }else{
            model.addAttribute("msg", "예약이 마감되었습니다");
            model.addAttribute("cmd", "back");
            return "common/alert";
        }
    }
}
