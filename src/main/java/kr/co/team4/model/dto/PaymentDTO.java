package kr.co.team4.model.dto;

import lombok.Data;

@Data
public class PaymentDTO {
    private int payment_idx;
    private int reservation_idx;
    private int paid_money;
    private String status;
}
