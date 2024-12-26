package kr.co.team4.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CalendarController {
    @GetMapping("/calendar.do")
    public String index() {
        return "calendar";
    }
}