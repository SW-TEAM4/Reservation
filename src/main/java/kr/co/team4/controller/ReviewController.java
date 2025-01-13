package kr.co.team4.controller;

import kr.co.team4.model.dto.ReviewDTO;
import kr.co.team4.model.dto.UserReservedDTO;
import kr.co.team4.model.service.S3Service;
import kr.co.team4.model.service.review.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.InputStream;
import java.math.BigInteger;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.CompletableFuture;

@Controller
@RequestMapping("/review")
public class ReviewController {
    @Autowired
    private ReviewService reviewService;
    @Autowired
    private S3Service s3Service;

    /**
     * 24.12.26 작성자 : 이윤채
     * 마이페이지/리뷰내역
     * Get/review/list
     * @return reviewListPage.jsp
     */
    @GetMapping("/list")
    public String listReviewController(HttpSession session, Model model) {
        BigInteger user_Idx = (BigInteger) session.getAttribute("user_Idx");
        if (user_Idx == null) {
            user_Idx = BigInteger.valueOf(0);
        }
        ReviewDTO dto = new ReviewDTO();
        dto.setUser_idx(user_Idx);
        model.addAttribute("count",reviewService.getReviewCount(dto));
//        System.out.println("Total review count: " + reviewService.getReviewCount(dto));
        model.addAttribute("map",reviewService.getReviewList(dto));

        // reviewListPage.jsp로 이동
        return "GetReviewListPage";
    }

    /**
     * 24.12.26 작성자 : 이윤채
     * 마이페이지/예약내역-리뷰작성
     * Get/reservation/
     * @return reviewPostPage
     */
    @GetMapping("")
    public String showReviewWritePage(@RequestParam int user_idx,
                                      @RequestParam int reservation_idx,
                                      @RequestParam int room_idx,
                                      Model model,ReviewDTO dto) {
        model.addAttribute("user_idx", user_idx);
        model.addAttribute("reservation_idx", reservation_idx);
        model.addAttribute("room_idx", room_idx);
        try {
            // 숙소 이름과 방 이름 조회
            UserReservedDTO reservedInfo = reviewService.getRoomAndLodgmentName(room_idx);

            if (reservedInfo == null) {
                model.addAttribute("error", "해당 room_idx에 대한 숙소 및 방 정보를 찾을 수 없습니다.");
            } else {
                model.addAttribute("lod_name", reservedInfo.getLod_name());
                model.addAttribute("room_name", reservedInfo.getRoom_name());
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "서버 오류가 발생했습니다.");
        }

        // 숙소 이름과 방 이름을 조회
        return "PostReviewPage";
    }

    /**
     * 24.12.26 작성자 : 이윤채
     * 마이페이지/예약내역-리뷰작성
     * Post/reservation/
     *
     * @return
     */
    @PostMapping("")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> postReviewController(
            @RequestParam("user_idx") int user_idx,
            @RequestParam("reservation_idx") int reservation_idx,
            @RequestParam("room_idx") int room_idx,
            @RequestParam("user_comment") String user_comment,
            @RequestParam("rating") float rating,
            @RequestParam(value = "review_img_url", required = false) MultipartFile reviewImgFile) {
        Map<String, Object> response = new HashMap<>();
        try {
            String reviewImgUrl = null;

            // DTO 생성 및 데이터 설정
            ReviewDTO reviewDTO = new ReviewDTO();
            reviewDTO.setUser_idx(BigInteger.valueOf(user_idx));
            reviewDTO.setReservation_idx(reservation_idx);
            reviewDTO.setRoom_idx(room_idx);
            reviewDTO.setUser_comment(user_comment);
            reviewDTO.setRating(rating);
            reviewDTO.setReview_img_url(reviewImgUrl);

            // 리뷰 등록 처리
            int result = reviewService.insertReview(reviewDTO);
            if (result == 1) {
                // 예약 상태 업데이트
                reviewService.updateReservationStatus(
                        reviewDTO.getUser_idx(),
                        reviewDTO.getReservation_idx(),
                        reviewDTO.getRoom_idx()
                );

                // 이미지가 있을 경우 비동기적으로 파일 업로드 및 URL 업데이트 처리
                if (reviewImgFile != null && !reviewImgFile.isEmpty()) {
                    // 비동기적으로 이미지 업로드 처리
                    CompletableFuture.runAsync(() -> {
                        try {
                            // S3에 업로드할 파일 Key 생성
                            String fileExtension = "";
                            String originalFileName = reviewImgFile.getOriginalFilename();
                            if (originalFileName != null && originalFileName.contains(".")) {
                                fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
                            }
                            String imgKey = String.format("review/%d%s", reservation_idx, fileExtension);

                            // S3에 파일 업로드
                            boolean uploadSuccess = s3Service.uploadFileToS3(imgKey, reviewImgFile);
                            if (uploadSuccess) {
                                // 업로드된 파일의 URL 생성
                                String finalReviewImgUrl = s3Service.getFileFromS3(imgKey);

                                // 리뷰 이미지 URL 업데이트 처리
                                reviewService.updateReviewImageUrl(reservation_idx, finalReviewImgUrl);
                            } else {
                                throw new RuntimeException("S3 파일 업로드 실패");
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    });
                }
                // 리뷰가 성공적으로 등록되었으므로 사용자에게 성공 메시지 전송
                response.put("status", "success");
                response.put("message", "리뷰가 성공적으로 등록되었습니다.");

            } else {
                response.put("status", "fail");
                response.put("message", "리뷰 등록에 실패했습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.put("status", "error");
            response.put("message", "서버 오류가 발생했습니다.");
        }
        return ResponseEntity.ok(response);
    }

}
