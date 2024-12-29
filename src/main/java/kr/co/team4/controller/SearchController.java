package kr.co.team4.controller;

import kr.co.team4.model.dto.LodgmentDTO;
import kr.co.team4.model.dto.SearchFilterDTO;
import kr.co.team4.model.service.SearchService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class SearchController {

    @Autowired
    private SearchService searchService;

    @GetMapping("/search/search.do")
    public String search(@RequestParam(value = "checkinDate", required = false) String checkinDate,
                         @RequestParam(value = "checkoutDate", required = false) String checkoutDate,
                         @RequestParam(value = "guestCount", required = false, defaultValue = "2") int guestCount,
                         @RequestParam(value = "petCount", required = false, defaultValue = "1") int petCount,
                         @RequestParam(value = "type", required = false, defaultValue = "전체") String type,
                         @RequestParam(value = "weight", required = false, defaultValue = "5kg 미만") String weight,
                         @RequestParam(value = "region", required = false, defaultValue = "전체") String region,
                         Model model) {

        // 필터 DTO 생성
        SearchFilterDTO filter = new SearchFilterDTO(checkinDate, checkoutDate, guestCount, petCount, type, weight, region);

        // 필터 조건에 맞는 숙소 검색
        List<LodgmentDTO> lodgments = searchService.searchLodgments(filter);

        // 검색 결과를 모델에 추가
        model.addAttribute("lodgments", lodgments);
        return "search/search";
    }
}
