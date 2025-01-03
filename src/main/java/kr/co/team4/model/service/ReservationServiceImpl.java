package kr.co.team4.model.service;

import kr.co.team4.model.dto.GetResDetailResDTO;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import kr.co.team4.model.dto.PaymentDTO;
import kr.co.team4.model.dto.ReservationDTO;
import kr.co.team4.model.dto.UserDTO;

import kr.co.team4.model.dto.UserReservedDTO;
import kr.co.team4.model.mapper.ReservationMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ReservationServiceImpl implements ReservationService {
    @Autowired
    private ReservationMapper reservationMapper;

    @Override
    public List<UserReservedDTO> getUserReservations(UserReservedDTO dto) {
        return reservationMapper.getUserReservations(dto);
    }
    
     /**
     * 작성자 :이윤채
     * 작성날짜 : 2024.12.30
     * 예약리스트--> 날짜 -> 요일 변환
     */
    @Override
    public Map<String, Object> list(UserReservedDTO dto) {
//        List<UserReservedDTO> list = reservationMapper.list(dto);

        // 날짜 변환을 위한 포맷터 설정
        DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd(E)", Locale.KOREAN);

        // 각 DTO의 res_str_date와 res_end_date를 변환
        list.forEach(item -> {
            // res_str_date 변환
            String resStrDate = item.getRes_str_date();
            if (resStrDate != null && !resStrDate.isEmpty()) {
                try {
                    LocalDate date = LocalDate.parse(resStrDate, inputFormatter);
                    String formattedDate = date.format(outputFormatter);
                    item.setRes_str_date(formattedDate);
                } catch (Exception e) {
                    System.err.println("Error formatting res_str_date: " + resStrDate);
                }
            }
            // res_end_date 변환
            String resEndDate = item.getRes_end_date();
            if (resEndDate != null && !resEndDate.isEmpty()) {
                try {
                    LocalDate date = LocalDate.parse(resEndDate, inputFormatter);
                    String formattedDate = date.format(outputFormatter);
                    item.setRes_end_date(formattedDate);
                } catch (Exception e) {
                    System.err.println("Error formatting res_end_date: " + resEndDate);
                }
            }
        });
        Map<String, Object> map = new HashMap<>();
        map.put("list", list);
        return map;
    }

    /**
     * 작성자 :이윤채
     * 작성날짜 : 2025.01.03
     * 예약상세--> 날짜 -> 요일 변환
     */
    @Override
    public List<GetResDetailResDTO> getResDetail(GetResDetailResDTO dto) {

        List<GetResDetailResDTO> getUserReservations = reservationMapper.getResDetail(dto);

        DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd(E)", Locale.KOREAN);

        // 각 DTO의 res_str_date와 res_end_date를 변환
        getUserReservations.forEach(item -> {
            // res_str_date 변환
            String resStrDate = item.getRes_str_date();
            if (resStrDate != null && !resStrDate.isEmpty()) {
                try {
                    LocalDate date = LocalDate.parse(resStrDate, inputFormatter);
                    String formattedDate = date.format(outputFormatter);
                    item.setRes_str_date(formattedDate);
                } catch (Exception e) {
                    System.err.println("Error formatting res_str_date: " + resStrDate);
                }
            }
            String resEndDate = item.getRes_end_date();
            if (resEndDate != null && !resEndDate.isEmpty()) {
                try {
                    LocalDate date = LocalDate.parse(resEndDate, inputFormatter);
                    String formattedDate = date.format(outputFormatter);
                    item.setRes_end_date(formattedDate);
                } catch (Exception e) {
                    System.err.println("Error formatting res_end_date: " + resEndDate);
                }
            }
        });
        return getUserReservations;
    }
  
    @Override
    public ReservationDTO getReservationInform(ReservationDTO dto) {
        return reservationMapper.getReservationInform(dto);
    }

    @Override
    public UserDTO getUserInform(ReservationDTO dto) {
        return reservationMapper.getUserInform(dto);
    }

    @Override
    @Transactional
    public boolean saveReservationPayment(PaymentDTO paymentDTO, ReservationDTO reservationDTO) {

        try{
            // 1. 예약 정보 저장 -> 저장 후 reservation_idx paymentDTO에 set
            reservationMapper.reserveAdd(reservationDTO);
            paymentDTO.setReservation_idx(reservationDTO.getReservation_idx().intValue());
            // 2. 예약 결제 정보 저장
            reservationMapper.paymentAdd(paymentDTO);
            return true;
        } catch (Exception e){
            // 저장 과정에 문제 발생
            return false;
        }
    }

    @Override
    @Transactional
    public boolean deleteReservationPayment(PaymentDTO paymentDTO, ReservationDTO reservationDTO){
        try{
            // 1. 예약 결제 정보 삭제
            paymentDTO = reservationMapper.getPaymentInform(reservationDTO.getRes_merchant_id());
            reservationMapper.paymentRemove(paymentDTO);

            // 2. 예약 정보 삭제
            reservationMapper.reserveRemove(reservationDTO);

            return true;
        }catch (Exception e){
            return false;
        }
    }

    @Override
    public boolean isAlreadyReserved(ReservationDTO reservationDTO) {
        // return 값이 1 이상이면 예약 가능함
        return reservationMapper.isAlreadyReserved(reservationDTO) > 0;
    }

    @Value("${imp.apiKey}")
    private String impKey;
    @Value("${imp.secretKey}")
    private String impSecretKey;

    @Override
    public Map<String, String> verifyPayment(String impUid, String merchantUid){
        Map<String, String> response = new HashMap<>();
        try{
            // 1. 아임포트 API 액세스 토큰 발급
            RestTemplate restTemplate = new RestTemplate();
            ObjectMapper objectMapper = new ObjectMapper();

            String tokenUrl = "https://api.iamport.kr/users/getToken";
            String tokenRequestBody = objectMapper.writeValueAsString(Map.of(
                    "imp_key", impKey,
                    "imp_secret", impSecretKey
            ));

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            HttpEntity<String> tokenEntity = new HttpEntity<>(tokenRequestBody, headers);

            ResponseEntity<String> tokenResponse = restTemplate.exchange(
                    tokenUrl, HttpMethod.POST, tokenEntity, String.class);

            if (!tokenResponse.getStatusCode().is2xxSuccessful()) {
                response.put("status", "fail");
                response.put("reason", "토큰 발급 실패");
            }

            JsonNode tokenResponseBody = objectMapper.readTree(tokenResponse.getBody());
            String accessToken = tokenResponseBody.get("response").get("access_token").asText();

            // 2. 포트원에서 결제 정보 단건 조회
            String paymentUrl = "https://api.iamport.kr/payments/" + impUid;
            HttpHeaders paymentHeaders = new HttpHeaders();
            paymentHeaders.set("Authorization", accessToken);

            HttpEntity<String> paymentEntity = new HttpEntity<>(paymentHeaders);
            ResponseEntity<String> paymentResponse = restTemplate.exchange(
                    paymentUrl, HttpMethod.GET, paymentEntity, String.class);

            if (!paymentResponse.getStatusCode().is2xxSuccessful()) {
                response.put("status", "failed");
                response.put("reason", "결제 조회 실패");
                return response;
            }

            // 3. 결제 금액 검증
            // 아임포트의 실제 지불된 금액과 payment 테이블의 실제 결제 금액과 비교
            JsonNode paymentData = objectMapper.readTree(paymentResponse.getBody()).get("response");
            int paidAmount = paymentData.get("amount").asInt();

            // db의 결제 데이터
            PaymentDTO paymentDTO =  reservationMapper.getPaymentInform(merchantUid);

            int orderAmount = paymentDTO.getPaid_money(); // 주문 금액 조회

            if (paidAmount != orderAmount) {
                response.put("status", "forgery");
                response.put("reason", "결제 금액 불일치");
                return response;
            }

            // 4. 결제 상태 확인 - paid 상태면 true 리턴하고 db의 payment 상태 갱신
            String status = paymentData.get("status").asText();

            if("paid".equals(status)) {
                paymentDTO.setStatus(status);
                reservationMapper.updatePayment(paymentDTO);
                response.put("status", status);
                return response;
            } else {
                // 실패 경우의 상태와 사유
                response.put("status", status);
                response.put("reason", (paymentData.get("fail_reason").asText()));
                return response;
            }
        } catch (Exception e){
            response.put("status", "failed");
            response.put("reason", e.getMessage());
        }
        return response;
    }
}
