package kr.co.team4.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LodRecentController {
    @RequestMapping("recently/recently.do")
    public String recent() {
        return "recently/recently"; // recently.jsp로 연결
    }
}

