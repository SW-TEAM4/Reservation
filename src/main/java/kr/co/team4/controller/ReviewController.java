package kr.co.team4.controller;

import kr.co.team4.model.dto.ReviewDTO;
import kr.co.team4.model.service.review.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/review")
public class ReviewController {
    @Autowired
    private ReviewService reviewService;
    @GetMapping("list")
    public String listReviewController(){
        return "reviewListPage";
    }

    @PostMapping("")
    public int postReviewController(@RequestBody ReviewDTO reviewDTO){
        int result = reviewService.insertReview(reviewDTO);
        return result;
    }

    @GetMapping("")
    public String showReviewWritePage(@RequestParam int user_idx,
                                      @RequestParam int reservation_idx,
                                      @RequestParam int room_idx,
                                      Model model) {
        model.addAttribute("user_idx", user_idx);
        model.addAttribute("reservation_idx", reservation_idx);
        model.addAttribute("room_idx", room_idx);
        return "reviewPostPage";  // 해당 JSP 페이지로 리턴
    }

}
