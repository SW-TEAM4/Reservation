package kr.co.team4.model.service;

import kr.co.team4.model.dto.ReservationDTO;
import kr.co.team4.model.dto.UserDTO;
import kr.co.team4.model.dto.UserReservedDTO;

import java.util.List;


public interface ReservationService {
    boolean reserveAdd (ReservationDTO dto);
    UserDTO getUserInform(ReservationDTO dto);
    List<UserReservedDTO> getUserReservations(UserReservedDTO dto);
}
