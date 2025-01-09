package kr.co.team4.controller;

import kr.co.team4.model.dto.LodLikeDTO;
import kr.co.team4.model.service.LodLikeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.math.BigInteger;
import java.util.HashMap;
import java.util.Map;


@Controller
@RequestMapping("/lodlike")
public class LodLikeController {

    @Autowired
    private LodLikeService lodLikeService;

    /**
     * 찜 상태 토글 (추가/삭제)
     */
    @PostMapping("/toggle")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> toggleLike(HttpSession session, @RequestBody Map<String, Object> requestBody) {
        Map<String, Object> response = new HashMap<>();

        try {
            int lod_idx = (int)requestBody.get("lod_idx");

            String redirectUrl = (String)requestBody.get("redirectUrl");
            // 세션에서 로그인 정보 가져오기
            BigInteger sessionUserIdx = (BigInteger) session.getAttribute("user_idx");
            if (sessionUserIdx == null) {
                response.put("status", "not_login");
                session.setAttribute("redirectUrl", redirectUrl);
                return ResponseEntity.ok(response);
            }

            LodLikeDTO lodLikeDTO = new LodLikeDTO();

            // 세션 사용자 ID를 DTO에 설정
            lodLikeDTO.setUser_idx(sessionUserIdx);
            lodLikeDTO.setLod_idx(lod_idx);

            // 디버깅 로그 추가
            System.out.println("요청 데이터: USER_IDX = " + lodLikeDTO.getUser_idx() + ", lod_idx = " + lodLikeDTO.getLod_idx());

            boolean isAdded = lodLikeService.toggleLike(lodLikeDTO);
            response.put("status", isAdded ? "added" : "removed");

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            e.printStackTrace(); // 예외 로그 출력
            response.put("error", "요청 처리 중 오류가 발생했습니다.");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    @GetMapping("/lodwish.do")
    public String goWish(){

        return "like/lodLikeList";
    }


}
