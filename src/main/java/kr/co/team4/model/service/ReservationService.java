package kr.co.team4.model.service;

import kr.co.team4.model.dto.PaymentDTO;
import kr.co.team4.model.dto.ReservationDTO;
import kr.co.team4.model.dto.UserDTO;
import kr.co.team4.model.dto.UserReservedDTO;

import java.util.List;
import java.util.Map;


public interface ReservationService {
    boolean saveReservationPayment(PaymentDTO paymentDTO, ReservationDTO reservationDTO);
    boolean deleteReservationPayment(PaymentDTO paymentDTO, ReservationDTO reservationDTO);
    // 특정 숙소 room에 예약 날짜 겹치는 경우 존재하는지 확인
    boolean isAlreadyReserved(ReservationDTO reservationDTO);

    // verify 수행 후 "status" , "fail_reason" 을 리턴
    Map<String, String> verifyPayment(String impUid, String merchantUid) throws Exception;
    List<UserReservedDTO> getUserReservations(UserReservedDTO dto);
    ReservationDTO getReservationInform(ReservationDTO dto);
    UserDTO getUserInform(ReservationDTO dto);
}
