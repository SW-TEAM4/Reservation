package kr.co.team4.model.service;

import config.MvcConfig;
import kr.co.team4.model.dto.UserReservedDTO;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.context.web.WebAppConfiguration;

import java.math.BigInteger;
import java.util.List;

@ExtendWith(SpringExtension.class)
@ContextConfiguration(classes = MvcConfig.class)
@WebAppConfiguration
public class testseller {
    @Autowired
    private SellerPageService sellerPageService;

    @Test
    @DisplayName("예약 데이터가 있는 유저의 예약 정보")  // 테스트 시 보이는 이름
    void testeSeller(){


        // 3. Assert 결과 검증
        // 예약이 존재하므로 null이 아니어야 한다.
       /* Assertions.assertNotNull(reservations, "예약이 존재하는 유저의 경우 예약 목록은 null이어서는 안 됩니다.");
        Assertions.assertFalse(reservations.isEmpty(), "예약 목록은 비어있을 수 없습니다.");*/
    }
}
