package kr.co.team4.model.mapper;

import kr.co.team4.model.dto.*;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ReservationMapper {

    // 예약 관련
    void reserveAdd(ReservationDTO dto);
    void reserveRemove(ReservationDTO dto);
    int isAlreadyReserved(ReservationDTO dto);
    UserDTO getUserInform(ReservationDTO dto);

    List<UserReservedDTO> list(UserReservedDTO dto);
    List<GetResDetailResDTO> getResDetail(GetResDetailResDTO dto);
    ReservationDTO getReservationInform(ReservationDTO dto);
    List<UserReservedDTO> getUserReservations(UserReservedDTO dto);

    // 결제 관련
    int calcReservePayment(ReservationDTO dto);
    void paymentAdd(PaymentDTO dto);
    void paymentRemove(PaymentDTO dto);
    PaymentDTO getPaymentInform(String res_merchant_id);
    void updatePayment(PaymentDTO dto);

    // 배치 관련
    List<Integer> getExpiredReservationIdxs();
    void deleteExpiredReservations(List<Integer> reservations);
    void deleteExpiredPayments(List<Integer>reservations);
}

