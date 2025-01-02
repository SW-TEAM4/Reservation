package kr.co.team4.controller;

import kr.co.team4.model.dto.LodReviewDTO;
import kr.co.team4.model.service.LodReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;

@Controller
public class LodReviewController {

    @Autowired
    private LodReviewService lodReviewService;

    // 숙소 리뷰 통계 및 리뷰 목록 조회
    @GetMapping("/lodreview.do")
    public String index(@RequestParam(value = "lod_idx", required = false) int lodIdx,
                        Model model) {
        // 통계 데이터 가져오기
        Map<String, Object> statistics = lodReviewService.getReviewStatistics(lodIdx);
        model.addAttribute("statistics", statistics);

        // 리뷰 목록 가져오기
        List<LodReviewDTO> reviewList = lodReviewService.getReviewList(lodIdx);
        model.addAttribute("reviewList", reviewList);

        // 한 화면에서 표시
        return "lodgment/lodreview"; // lodreview.jsp로 이동
    }
}