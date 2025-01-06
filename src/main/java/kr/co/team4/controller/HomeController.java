package kr.co.team4.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.math.BigInteger;

@Controller
public class HomeController {
 //   @GetMapping("/home.do")
   // public String index() {
      //  return "home";
   // }
 @GetMapping("/home.do")
 public String home(@RequestParam(value = "user_idx", required = false) BigInteger userIdx, HttpSession session, Model model) {
     // 세션에서 user_idx 가져 옴 (로그인하지 않았으면 null)
     BigInteger sessionUserIdx = (BigInteger) session.getAttribute("user_idx");

     // 세션 또는 쿼리 파라미터로 전달된 user_idx를 모델에 추가
     model.addAttribute("user_idx", sessionUserIdx != null ? sessionUserIdx : userIdx);

     return "home";
 }

}
