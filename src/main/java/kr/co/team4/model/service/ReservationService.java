package kr.co.team4.model.service;

import kr.co.team4.model.dto.GetResDetailResDTO;
import kr.co.team4.model.dto.ReservationDTO;
import kr.co.team4.model.dto.UserDTO;
import kr.co.team4.model.dto.UserReservedDTO;

import java.util.List;

import java.util.Map;


public interface ReservationService {

    Map<String, Object> list(UserReservedDTO dto);
    List<GetResDetailResDTO>getResDetail(GetResDetailResDTO dto);

    boolean reserveAdd (ReservationDTO dto);
    UserDTO getUserInform(ReservationDTO dto);
    List<UserReservedDTO> getUserReservations(UserReservedDTO dto);

}
