package kr.co.team4.model.mapper;

import kr.co.team4.model.dto.ReservationDTO;
import kr.co.team4.model.dto.UserDTO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ReservationMapper {
    int reserveAdd(ReservationDTO dto);
    UserDTO getUserInform(ReservationDTO dto);
}
