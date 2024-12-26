package kr.co.team4.model.mapper;
import kr.co.team4.model.dto.ReseravtionDTO;
import org.apache.ibatis.annotations.Mapper;
import kr.co.team4.model.dto.ReservationDTO;
import kr.co.team4.model.dto.UserDTO;

import java.util.List;

@Mapper
public interface ReservationMapper {
    int reserveAdd(ReservationDTO dto);
    UserDTO getUserInform(ReservationDTO dto);
    List<ReseravtionDTO> list(ReseravtionDTO dto);
}

