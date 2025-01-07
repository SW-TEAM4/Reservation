package kr.co.team4.controller;

import kr.co.team4.model.dto.LodgmentDTO;
import kr.co.team4.model.dto.SearchFilterDTO;
import kr.co.team4.model.service.LodReviewService;
import kr.co.team4.model.service.SearchService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import software.amazon.awssdk.services.s3.endpoints.internal.Value;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class SearchController {

    @Autowired
    private SearchService searchService;

    @Autowired
    private LodReviewService lodReviewService; // LodReviewService 추가

    @GetMapping("/search/search.do")
    public String search(@RequestParam(value = "checkinDate", required = false) String checkinDate,
                         @RequestParam(value = "checkoutDate", required = false) String checkoutDate,
                         @RequestParam(value = "guestCount", required = false, defaultValue = "2") int guestCount,
                         @RequestParam(value = "petCount", required = false, defaultValue = "1") int petCount,
                         @RequestParam(value = "type", required = false, defaultValue = "0") int type,
                         @RequestParam(value = "weight", required = false, defaultValue = "0") int weight,
                         @RequestParam(value = "region", required = false, defaultValue = "0") int region,
                         Model model) {

        // 필터 DTO 생성
        SearchFilterDTO filter = new SearchFilterDTO(checkinDate, checkoutDate, guestCount, petCount, type, weight, region);

        // 필터 조건에 맞는 숙소 검색
        List<LodgmentDTO> lodgments = searchService.searchLodgments(filter);

        // 각 숙소에 대한 리뷰 통계 추가
        for (LodgmentDTO lodgment : lodgments) {
            Map<String, Object> statistics = lodReviewService.getReviewStatistics(lodgment.getLod_idx());
            int reviewCount = statistics.get("REVIEW_COUNT") != null ? ((Long) statistics.get("REVIEW_COUNT")).intValue() : 0;
            double avgRating = statistics.get("AVG_RATING") != null ? ((Double) statistics.get("AVG_RATING")) : 0.0;

            lodgment.setReviewCount(reviewCount);
            lodgment.setAvgRating(avgRating);
        }

        // 검색 결과를 모델에 추가
        model.addAttribute("lodgments", lodgments);
        return "search/search";
    }

    @GetMapping("/search/updateUI.do")
    @ResponseBody
    public Map<String, Object> searchUpdate(Model model,
                                            @RequestParam(value = "checkinDate", required = false) String checkinDate,
                                            @RequestParam(value = "checkoutDate", required = false) String checkoutDate,
                                            @RequestParam(value = "guestCount", required = false, defaultValue = "2") int guestCount,
                                            @RequestParam(value = "petCount", required = false, defaultValue = "1") int petCount,
                                            @RequestParam(value = "type", required = false, defaultValue = "0") int type,
                                            @RequestParam(value = "weight", required = false, defaultValue = "0") int weight,
                                            @RequestParam(value = "region", required = false, defaultValue = "0") int region
                                            ) {
        Map<String, Object> response = new HashMap<>();

        // 필터 DTO 생성
        SearchFilterDTO filter = new SearchFilterDTO(checkinDate, checkoutDate, guestCount, petCount, type, weight, region);

        // 필터 조건에 맞는 숙소 검색
        List<LodgmentDTO> lodgments = searchService.searchLodgments(filter);

        // 검색 결과를 모델에 추가
        model.addAttribute("lodgments", lodgments);

        // 각 숙소에 대한 리뷰 통계 추가
        for (LodgmentDTO lodgment : lodgments) {
            Map<String, Object> statistics = lodReviewService.getReviewStatistics(lodgment.getLod_idx());
            int reviewCount = statistics.get("REVIEW_COUNT") != null ? ((Long) statistics.get("REVIEW_COUNT")).intValue() : 0;
            double avgRating = statistics.get("AVG_RATING") != null ? ((Double) statistics.get("AVG_RATING")) : 0.0;

            lodgment.setReviewCount(reviewCount);
            lodgment.setAvgRating(avgRating);
        }

        // 응답에 추가
        response.put("lodgments", lodgments);
        response.put("checkinDate", checkinDate);
        response.put("checkoutDate", checkoutDate);
        response.put("guestCount", guestCount);
        response.put("petCount", petCount);
        return response;
    }
}
