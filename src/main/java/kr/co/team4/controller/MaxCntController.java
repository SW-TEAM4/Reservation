package kr.co.team4.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MaxCntController {

    // index.jsp로 이동 (GET 요청)
    @GetMapping("/index.do")
    public String index(@RequestParam(value = "adultCount", required = false) Integer adultCount,
                        @RequestParam(value = "childCount", required = false) Integer childCount,
                        Model model) {
        // URL 파라미터가 null이면 기본값 설정
        if (adultCount == null) {
            adultCount = 2; // 기본값 성인 2명
        }
        if (childCount == null) {
            childCount = 1; // 기본값 아동 1명
        }

        // 변경된 값을 모델에 추가
        model.addAttribute("adultCount", adultCount);
        model.addAttribute("childCount", childCount);

        return "index";  // index.jsp로 이동
    }

    // maxcnt.jsp로 이동 (GET 요청)
    @GetMapping("/maxcnt.do")
    public String maxcnt(@RequestParam(value = "adultCount", required = false) Integer adultCount,
                         @RequestParam(value = "childCount", required = false) Integer childCount,
                         Model model) {
        // URL 파라미터가 null이면 기본값 설정
        if (adultCount == null) {
            adultCount = 2; // 기본값 성인 2명
        }
        if (childCount == null) {
            childCount = 1; // 기본값 아동 1명
        }

        // 변경된 값을 모델에 추가
        model.addAttribute("adultCount", adultCount);
        model.addAttribute("childCount", childCount);

        return "maxcnt";  // maxcnt.jsp로 이동
    }

    // maxcnt.jsp에서 POST 요청을 처리할 때 (변경된 값 저장)
    @PostMapping("/maxcnt.do")
    public String saveCount(@RequestParam("adultCount") int adultCount,
                            @RequestParam("childCount") int childCount,
                            Model model) {
        // 모델에 값 저장
        model.addAttribute("adultCount", adultCount);
        model.addAttribute("childCount", childCount);
        return "redirect:/index.do?adultCount=" + adultCount + "&childCount=" + childCount; // index.jsp로 리다이렉트
    }
}