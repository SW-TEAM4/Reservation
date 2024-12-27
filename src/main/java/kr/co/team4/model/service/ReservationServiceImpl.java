package kr.co.team4.model.service;

import kr.co.team4.model.dto.ReservationDTO;
import kr.co.team4.model.dto.UserDTO;
import kr.co.team4.model.dto.UserReservedDTO;
import kr.co.team4.model.mapper.ReservationMapper;
import kr.co.team4.model.mapper.RoomMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
