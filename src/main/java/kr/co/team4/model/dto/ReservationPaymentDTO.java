package kr.co.team4.model.dto;

import lombok.Data;

@Data
public class ReservationPaymentDTO {
    private PaymentDTO paymentDTO;
    private ReservationDTO reservationDTO;
}
