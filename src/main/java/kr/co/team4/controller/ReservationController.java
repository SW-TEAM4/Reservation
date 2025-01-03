package kr.co.team4.controller;

import kr.co.team4.model.dto.*;
import kr.co.team4.model.service.ReservationService;
import kr.co.team4.model.service.RoomService;
import kr.co.team4.model.service.S3Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ReservationController {
    /*
    * 예약 페이지 관련 컨트롤러 클래스
    *
    * type: Get
    * method: goReservation()
    * param: @RequestParam int room_idx,
    *        @RequestParam String checkinDate,
    *        @RequestParam String checkoutDate,
    *        @RequestParam int res_people_cnt,
    *        @RequestParam int res_pets_cnt
    * 기능: Get요청으로 받은 RequestParam을 이용해서 예약 하려는 정보들을 받아서 reservation 페이지 구성 및 이동
    * ReservationDTO, RoomDTO, LodgmentDTO, UserDTO를 받아오고, 이를 활용해 reservation.jsp 페이지를 구성
    * return: String (페이지 이동)

    * type: Post
    * method: saveReservationPayment()
    * param: @RequestBody ReservationPaymentDTO
    * 기능: 예약 정보와 결제 예정의 결제 정보를 각각 RESERVATION, PAYMENT 테이블에 저장
    * 파라미터로 ReservationDTO와 PaymentDTO로 구성된 ReservationPaymentDTO를 받음
    * return: ResponseEntity<Map<String, Object>>
    *
    * type: Post
    * method: deleteReservationPayment()
    * param: @RequestBody Map<String, String> requestBody
    * 기능: merchant_id를 받아서 그 값을 갖는 RESERVATION 튜플과 PAYMENT 튜플을 테이블에서 삭제
    * 파라미터로 Map 형태의 "merchant_id"와 그 값을 받아옴
    * return: ResponseEntity<Map<String, Object>>
    *
    * type: Post
    * method: completePayment()
    * request: @RequestBody Map<String, String> portonePayload
    * 기능: 포트원으로 부터 응답받은 imp_id와 merchant_id를 이용해
    * 실제 db에서의 결제 정보와 아임포트 상에서 결제된 결제 정보를 비교하여 정상적인 결제가 이루어졌는지 검증
    * return: ResponseEntity<Map<String, Object>>
    *
    * type: Post
    * method: completePayment()
    * request: @RequestBody Map<String, String> portonePayload
    * 기능: 포트원으로 부터 응답받은 imp_id와 merchant_id를 이용해
    * 실제 db에서의 결제 정보와 아임포트 상에서 결제된 결제 정보를 비교하여 정상적인 결제가 이루어졌는지 검증
    * return: ResponseEntity<Map<String, Object>>
    */
    @Autowired
    private ReservationService reservationService;
    @Autowired
    private RoomService roomService;
    @Autowired
    private S3Service s3Service;

    /**
     * 24.12.26 작성자 : 이윤채
     * (변경)2024.12.30 작성자 : 이윤채
     * (변경내용)mypage에서 가져온 세션 값 user_Idx로 교체
     * (업데이트 할 내용)로그인 완료되면 로그인에서 새션값 들고 오기
     * 마이페이지/예약내역
     * Get /reservation/list
     * @return GetReservationListPage
     */
    @GetMapping("/reservation/list")
    public String listReservationList(HttpSession session, Model model) {
        // 세션에서 user_Idx 값 가져오기
        BigInteger user_Idx = (BigInteger) session.getAttribute("user_Idx");
        if (user_Idx == null) {
            user_Idx = BigInteger.valueOf(0);
        }
        UserReservedDTO dto = new UserReservedDTO();
        dto.setUser_idx(user_Idx); // 세션에서 가져온 user_Idx 값 설정

        // 예약 목록 가져오기 (Map을 반환받음)
        Map<String, Object> resultMap = reservationService.list(dto);

        // 결과에서 List<UserReservedDTO>를 추출
        List<UserReservedDTO> userReservedDTOList = (List<UserReservedDTO>) resultMap.get("list");  // "list"는 Map의 키값에 맞게 수정

        // S3에서 숙소 이미지 URL을 추가하는 로직
        try {
            for (UserReservedDTO myReservation : userReservedDTOList) {
                // 이미지 키 형성 (lodgment/${LOD_IDX}.jpg)
                String imageKey = "lodgment/" + myReservation.getLod_idx() + ".jpg"; // 확장자 설정 (예시로 jpg)
                if (imageKey != null && !imageKey.isEmpty()) {
                    // S3에서 이미지 URL을 가져와서 설정
                    String imageUrl = s3Service.getFileFromS3(imageKey); // bucketName 전달 필요 없음
                    myReservation.setLod_img_url(imageUrl); // 예약 객체에 이미지 URL 설정
                }
            }
        } catch (Exception e) {
            // 예외 발생 시 에러 메시지를 포함하여 일반적인 예외 던지기
            throw new RuntimeException("사진 조회에 실패하였습니다.");
        }

        model.addAttribute("map", reservationService.list(dto));


        return "GetReservationListPage";
    }



    /**
     * 예약 상세 정보 페이지
     * @param session 세션에서 user_idx와 reservation_idx를 가져옴
     * @param model 모델 객체에 데이터를 추가
     * @return GetReservationDetail 페이지
     */
    @GetMapping("/reservation/detailInfo")
    public String getResDetail(
            @RequestParam("user_idx") BigInteger user_idx,  // 쿼리 파라미터로 받은 user_idx
            @RequestParam("reservation_idx") BigInteger reservation_idx,  // 쿼리 파라미터로 받은 reservation_idx
            Model model) {

        // 예약 상세 정보 가져오는 서비스 호출
        GetResDetailResDTO dto = new GetResDetailResDTO();
        dto.setUser_idx(user_idx);
        dto.setReservation_idx(reservation_idx);

        List<GetResDetailResDTO> resDetails = reservationService.getResDetail(dto);

        Map<String, Object> resDetailMap = new HashMap<>();
        if (!resDetails.isEmpty()) {
            GetResDetailResDTO detail = resDetails.get(0); // 리스트에서 첫 번째 항목 사용
            resDetailMap.put("lod_name", detail.getLod_name());
            resDetailMap.put("room_name", detail.getRoom_name());
            resDetailMap.put("room_idx", detail.getRoom_idx());
            resDetailMap.put("room_photo_url", detail.getRoom_photo_url());
            resDetailMap.put("res_str_date", detail.getRes_str_date());
            resDetailMap.put("res_end_date", detail.getRes_end_date());
            resDetailMap.put("lod_check_in", detail.getLod_check_in());
            resDetailMap.put("lod_check_out", detail.getLod_check_out());
            resDetailMap.put("total_res_day", detail.getTotal_res_day());
            resDetailMap.put("res_people_cnt", detail.getRes_people_cnt());
            resDetailMap.put("res_pets_cnt", detail.getRes_pets_cnt());
            resDetailMap.put("paid_money", detail.getPaid_money());
            resDetailMap.put("request", detail.getRequest());
            if (detail.getCreated() != null) {
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 a hh:mm");
                String formattedDate = detail.getCreated().format(formatter);
                resDetailMap.put("created", formattedDate);
            }
        }

        model.addAttribute("reservation", resDetailMap);
        // 예약 상세 페이지로 이동
        return "GetReservationDetail";  // 예약 상세 화면으로 이동
    }

    // room_idx를 이용해 방정보를 가져오고 이를 이용한 예약 화면 화면 출력
    @GetMapping("/reserve/reservation.do")
    public String goReservtion(Model model,
                               @RequestParam int room_idx,
                               @RequestParam String checkinDate,
                               @RequestParam String checkoutDate,
                               @RequestParam int res_people_cnt,
                               @RequestParam int res_pets_cnt){

        ReservationDTO reservationDTO = new ReservationDTO();

        // String으로 들어온 날짜를 Date 타입으로 변환
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try{
            Date res_str_date = sdf.parse(checkinDate);
            Date res_end_date = sdf.parse(checkoutDate);

            reservationDTO.setRoom_idx(BigInteger.valueOf(room_idx));
            reservationDTO.setRes_str_date(res_str_date);
            reservationDTO.setRes_end_date(res_end_date);
            reservationDTO.setRes_people_cnt(res_people_cnt);
            reservationDTO.setRes_pets_cnt(res_pets_cnt);

            RoomDTO roomDTO = roomService.getRoomDetail(room_idx);
            // 세션에 저장되어 있는 유저 idx 정보를 통해 유저 정보 가져오기
            // reservationDTO.setUser_idx(BigInteger.valueOf(1));

            LodgmentDTO lodDTO = roomService.getRoomLodDetail(roomDTO.getLod_idx());
            UserDTO userDTO = reservationService.getUserInform(reservationDTO);


            model.addAttribute("formattedCheckinTime", lodDTO.getFormattedLodCheckIn());
            model.addAttribute("formattedCheckoutTime", lodDTO.getFormattedLodCheckOut());
            model.addAttribute("formattedCheckinDate", reservationDTO.getFormattedCheckinDate());
            model.addAttribute("formattedCheckoutDate", reservationDTO.getFormattedCheckoutDate());
            model.addAttribute("formattedRoomPrice", roomDTO.getFormattedRoomPrice());
            model.addAttribute("dayDifference", reservationDTO.getDateDifferenceDays());
            model.addAttribute("reservationDTO", reservationDTO);
            model.addAttribute("roomDTO", roomDTO);
            model.addAttribute("lodDTO", lodDTO);
            model.addAttribute("userDTO", userDTO);
            return "reserve/reservation";
        } catch (Exception e){
            e.printStackTrace();
        }
        // 예약 화면 출력 과정에서 에러 발생시 홈페이지 이동
        return "redirect:/home.do";
    }

    @GetMapping("/reserve/getUserReserved.do")
    public void getUserReserved(Model model, UserReservedDTO userReservedDTO){
        // userReservedDTO의 user_idx가 널이 아니라면 해당 유저의 예약 정보들 가져옴
        if(userReservedDTO.getUser_idx() != null){
            model.addAttribute("userReservedDTO", reservationService.getUserReservations(userReservedDTO));
        }
    }

    // 예약,결제 예정 정보 저장
    @PostMapping("/reservation/saveReservationPayment.do")
    public ResponseEntity<Map<String, Object>> saveReservationPayment(@RequestBody ReservationPaymentDTO reservationPaymentDTO) {
        Map<String,Object> response = new HashMap<>();
        ReservationDTO reservationDTO = reservationPaymentDTO.getReservationDTO();
        PaymentDTO paymentDTO = reservationPaymentDTO.getPaymentDTO();

        try {
            // 예약 중복 체크
            if(!reservationService.isAlreadyReserved(reservationDTO)){
                // 중복 예약이 있을 경우 에러 반환
                response.put("success", false);
                response.put("message", "이미 예약이 마감되었습니다.");
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
            }

            // 예약 및 결제 정보 저장
            paymentDTO.setStatus("pending");
            reservationDTO.setStatus("A");
            reservationService.saveReservationPayment(paymentDTO, reservationDTO);

            // PaymentDTO, ReservationDTO 리턴 (merchant_id 필요함, completePayment에 )
            response.put("success", true);
            response.put("message", "예약 정보와 결제 정보가 저장되었습니다.");
            response.put("userDTO", reservationService.getUserInform(reservationPaymentDTO.getReservationDTO()));
            response.put("reservationPaymentDTO", reservationPaymentDTO);

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "예약 및 결제 정보 저장에 실패했습니다.");
            response.put("error", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    @PostMapping("/reservation/deleteReservationPayment.do")
    // 예약,결제 예정 정보 삭제
    public ResponseEntity<Map<String, Object>> deleteReservationPayment(@RequestBody Map<String, String> requestBody) {
        Map<String,Object> response = new HashMap<>();
        String merchant_id = requestBody.get("merchant_id");

        try {
            ReservationDTO reservationDTO = new ReservationDTO();
            reservationDTO.setRes_merchant_id(merchant_id);
            reservationService.deleteReservationPayment(new PaymentDTO(), reservationDTO);

            response.put("success", true);
            response.put("message", "예약 정보와 결제 정보가 삭제되었습니다.");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "예약 및 결제 정보 삭제에 실패했습니다.");
            response.put("error", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    // 결제 정보 db와 실제 결제한 사이트의 결제 정보와 비교
    @CrossOrigin(origins = "http://localhost:8090")
    @PostMapping("/payment/complete")
    public ResponseEntity<Map<String, Object>> completePayment(@RequestBody Map<String, String> portonePayload){
        Map<String, Object> response = new HashMap<>();
        try{
            String imp_uid = portonePayload.get("imp_uid");
            String res_merchant_id = portonePayload.get("merchant_uid");

            // 결제 검증 로직 수행
            Map<String, String> isVerified = reservationService.verifyPayment(imp_uid, res_merchant_id);

            if ("paid".equals(isVerified.get("status"))) {
                // 결제 검증 성공 후, 클라이언트에 리디렉션할 URL 반환
                response.put("success", true);
                response.put("message", "결제가 성공적으로  완료되었습니다.");
                return ResponseEntity.ok(response);
            } else {
                // 결제 취소
                response.put("success", false);
                response.put("status", isVerified.get("status"));
                response.put("message", isVerified.get("reason"));
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
            }
        } catch (Exception e){
            response.put("success", false);
            response.put("message", "결제 처리 중 오류 발생: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
}
