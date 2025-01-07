package kr.co.team4.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class FunController {

    @GetMapping("/fun.do")
    public String showFun() {
        return "fun/fun";
    }

    @GetMapping("/event1")
    public String showevent1() { return "fun/event1"; }

    @GetMapping("/event2")
    public String showevent2() { return "fun/event2"; }

    @GetMapping("/event3")
    public String showevent3() { return "fun/event3"; }


}
