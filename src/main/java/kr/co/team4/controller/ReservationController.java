package kr.co.team4.controller;

import kr.co.team4.model.dto.GetResDetailResDTO;
import kr.co.team4.model.dto.ReservationDTO;
import kr.co.team4.model.dto.UserReservedDTO;
import kr.co.team4.model.service.ReservationService;
import kr.co.team4.model.service.RoomService;
import kr.co.team4.model.service.S3Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
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
    * type: Post
    * method: reserveAdd()
    * 기능: 예약 정보를 reservation table에 저장
    * 예약이 가능하다면 reservation table에 저장 후 결제 페이지 이동,
    * 예약 불가능하면 이전 페이지로 이동
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

    @GetMapping("/reserve/reservationtest.do")
    public String index(){
        return "reserve/reservation";
    }

    // 날짜 형식 설정 (yyyy-MM-dd'T'HH:mm)
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }

    @PostMapping("/reserve/saveReservation.do")
    public void saveReserve(Model model, @RequestParam("res_status") String status, ReservationDTO reservationDTO){
        reservationDTO.setStatus(status);
        if(reservationService.reserveAdd(reservationDTO)){
            // db에 예약 정보 성공적으로 저장 후 model에 예약 정보와, 실제 users의 정보 저장
            model.addAttribute("reserveDTO", reservationDTO);
            model.addAttribute("user", reservationService.getUserInform(reservationDTO));
        }
    }

    // room_idx를 이용해 방정보를 가져오고 이를 이용한 예약 화면 화면 출력
    @GetMapping("/reserve/reservation.do")
    public String goReservtion(Model model, @RequestParam("room_idx") int room_idx){
        model.addAttribute("roomDTO", roomService.getRoomDetail(room_idx));
        return "reserve/reservation";
    }


    @PostMapping("/reserve/reservation.do")
    public String goPayment(Model model,@ModelAttribute ReservationDTO reservationDTO){
        if(reservationService.reserveAdd(reservationDTO)){
            // Todo 결제창에서 필요한 데이터 추가
            //model.add
            return "payment/payment";
        }else{
            model.addAttribute("msg", "예약이 마감되었습니다");
            model.addAttribute("cmd", "back");
            return "common/alert";
        }
    }

    @GetMapping("/reserve/getUserReserved.do")
    public void getUserReserved(Model model, UserReservedDTO userReservedDTO){
        // userReservedDTO의 user_idx가 널이 아니라면 해당 유저의 예약 정보들 가져옴
        if(userReservedDTO.getUser_idx() != null){
            model.addAttribute("userReservedDTO", reservationService.getUserReservations(userReservedDTO));
        }
    }
}
