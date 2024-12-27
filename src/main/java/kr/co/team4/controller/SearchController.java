package kr.co.team4.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class SearchController {
    @GetMapping("/search/search.do")
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
        return "search/search";
    }
}
