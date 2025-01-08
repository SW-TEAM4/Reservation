package kr.co.team4.model.service;

import config.MvcConfig;
import kr.co.team4.model.dto.UserReservedDTO;
import kr.co.team4.model.mapper.ReservationMapper;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Import;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.context.web.WebAppConfiguration;

import java.math.BigInteger;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertNotNull;

@ExtendWith(SpringExtension.class)
@ContextConfiguration(classes = MvcConfig.class)
@WebAppConfiguration
public class ReservationTests {

    @Autowired
    private ReservationService reservationService;

    @Autowired
    private ReservationMapper reservationMapper;

    @Test
    @DisplayName("예약 데이터가 있는 유저의 예약 정보")
    void testGetUsersReservations(){
        UserReservedDTO testDTO = new UserReservedDTO();

        // 1. 데이터 세팅: 실제 db에 존재하는 user idx로 테스트
        // 예약 데이터가 존재하는 경우의 유저
        testDTO.setUser_idx(BigInteger.valueOf(1));

        // 2. 서비스 메서드 호출
        List<UserReservedDTO> reservations = reservationService.getUserReservations(testDTO);
        // 3. Assert 결과 검증
        // 예약이 존재하므로 null이 아니어야 한다.
        Assertions.assertNotNull(reservations, "예약이 존재하는 유저의 경우 예약 목록은 null이어서는 안 됩니다.");
        Assertions.assertFalse(reservations.isEmpty(), "예약 목록은 비어있을 수 없습니다.");
    }

    @Test
    @DisplayName("예약 데이터가 없는 유저의 예약 정보")
    void testGetUsersReservationsNo(){
        UserReservedDTO testDTO = new UserReservedDTO();

        // 1. 데이터 세팅: 실제 db에 존재하는 user idx로 테스트
        // 예약 데이터가 존재하는 경우의 유저
        testDTO.setUser_idx(BigInteger.valueOf(17));

        // 2. 서비스 메서드 호출
        List<UserReservedDTO> reservations = reservationService.getUserReservations(testDTO);
        // 3. Assert 결과 검증
        Assertions.assertTrue(reservations.isEmpty(), "예약 목록이 없는 유저는 빈 리스트를 반환한다");
    }
}
