package kr.co.team4.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LodRecentController {
    @RequestMapping("/recent.do")
    public String recent() {
        return "recent"; // recent.jsp로 연결
    }
}

