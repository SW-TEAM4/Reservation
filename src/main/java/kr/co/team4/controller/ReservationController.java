package kr.co.team4.controller;

import com.fasterxml.jackson.annotation.JsonCreator;
import kr.co.team4.model.dto.ReseravtionDTO;
import kr.co.team4.model.service.reservation.ReservationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/reservation")
public class ReservationController {

    @Autowired
    private ReservationService reservationService;

    @GetMapping("/list")
    public String listReservationList(Model model, ReseravtionDTO dto) {
        dto.setUser_idx(1);
       model.addAttribute("map",reservationService.list(dto));
        return "reservationListPage";
    }
}
