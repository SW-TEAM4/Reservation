package kr.co.team4.controller;

import kr.co.team4.model.dto.TestDTO;
import kr.co.team4.model.service.TestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TestHomeController {

    @Autowired
    private TestService testService;

    @GetMapping("/test/index.do")
    public String list(Model model, TestDTO dto)
    {
        model.addAttribute("map", testService.list(dto));
        model.addAttribute("count", testService.count(dto));
        return "test/index";
    }

//    @GetMapping("/test/index.do")
//    public String count(Model model, TestDTO dto){
//        model.addAttribute("count", testService.count(dto));
//        return "test/index";
//    }

    @RequestMapping("/")
    public String x(){
        return "index";
    }
}
