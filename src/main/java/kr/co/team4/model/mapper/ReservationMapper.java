package kr.co.team4.model.mapper;

import kr.co.team4.model.dto.ReservationDTO;
import kr.co.team4.model.dto.UserDTO;
import kr.co.team4.model.dto.UserReservedDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ReservationMapper {
    int reserveAdd(ReservationDTO dto);
    UserDTO getUserInform(ReservationDTO dto);
    List<UserReservedDTO> getUserReservations(UserReservedDTO dto);
}
