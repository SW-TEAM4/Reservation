package kr.co.team4.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PaymentController {

    @RequestMapping("/payment/payment.do")
    public String go(){
        return "payment/payment";
    }
}
