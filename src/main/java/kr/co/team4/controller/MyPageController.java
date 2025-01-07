package kr.co.team4.controller;

import kr.co.team4.model.dto.UserDTO;
import kr.co.team4.model.dto.UserReservedDTO;
import kr.co.team4.model.service.review.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;
import java.math.BigInteger;

@Controller
public class MyPageController {
    @Autowired
    private ReviewService reviewService;
    /**
     * 24.12.26 작성자 : 이윤채
     * (변경)2024.12.30 작성자 : 이윤채
     * (변경내용)일단 mypage에서 하드코딩으로 user_Idx박고 새션에 저장함
     * (업데이트 할 내용)로그인 완료되면 로그인에서 새션값 들고 오기
     * 마이페이지/예약내역
     * Get /reservation/list
     * @return reservationListPage
     */
//    @GetMapping("/mypage.do")
//    public String index(HttpSession session, Model model) {
//        BigInteger user_Idx = new BigInteger("1"); // 예시로 1로 설정
//        session.setAttribute("user_Idx", user_Idx); // 세션에 user_Idx 저장
//        model.addAttribute("user_Idx", user_Idx.toString());
//        UserReservedDTO userReservedDTO = reviewService.getUserName(user_Idx.intValue());
//        model.addAttribute("userReservedDTO", userReservedDTO);
//        return "mypage";
//    }
    @GetMapping("/mypage.do")
    public String index(HttpSession session, Model model) {
        // 세션에서 usersession 가져오기
        UserDTO user = (UserDTO) session.getAttribute("usersession");

        if (user == null) {
            // 로그인하지 않은 사용자라면 로그인 페이지로 리다이렉트
            return "redirect:/userlogin";
        }

        // 로그인한 사용자 정보 사용
        BigInteger user_Idx = user.getUSER_IDX(); // 예시로 UserDTO에서 userIdx를 가져옴
        session.setAttribute("user_Idx", user_Idx); // 세션에 user_Idx 저장

        // 모델에 user_Idx 추가
        model.addAttribute("user_Idx", user_Idx.toString());

        // 추가적인 사용자 정보 처리 (예시로 getUserName 호출)
        UserReservedDTO userReservedDTO = reviewService.getUserName(user_Idx.intValue());
        model.addAttribute("userReservedDTO", userReservedDTO);

        return "mypage";
    }


}
