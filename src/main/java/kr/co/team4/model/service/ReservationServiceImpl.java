package kr.co.team4.model.service;

import kr.co.team4.model.dto.GetResDetailResDTO;
import kr.co.team4.model.dto.ReservationDTO;
import kr.co.team4.model.dto.UserDTO;

import kr.co.team4.model.dto.UserReservedDTO;
import kr.co.team4.model.mapper.ReservationMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;

import java.util.List;

@Service
public class ReservationServiceImpl implements ReservationService {
    /*
     * method: reserveAdd
     * param: ReserveDTO
     * return: boolean
     * 기능: reservation 정보가 성공적으로 db에 저장되면 true, 저장 실패시 false
     *
     * method: getUserInform
     * param: ReserveDTO
     * return: UserDTO - user_idx, user_name, user_email, user_phone_number
     * 기능: ReserveDTO의 user_idx를 이용해 해당 유저의 이름, 이메일, 전화번호 정보를 리턴
     */
    @Autowired
    private ReservationMapper reservationMapper;

    /**
     * 작성자 :이윤채
     * 작성날짜 : 2024.12.30
     * 예약리스트--> 날짜 -> 요일 변환
     */
    @Override
    public Map<String, Object> list(UserReservedDTO dto) {
        List<UserReservedDTO> list = reservationMapper.list(dto);

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
    public boolean reserveAdd(ReservationDTO dto) {
        return reservationMapper.reserveAdd(dto) > 0;
    }

    @Override
    public UserDTO getUserInform(ReservationDTO dto) {
        return reservationMapper.getUserInform(dto);
    }

    @Override
    public List<UserReservedDTO> getUserReservations(UserReservedDTO dto) {
        return reservationMapper.getUserReservations(dto);
    }

}
