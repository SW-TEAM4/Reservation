package kr.co.team4.model.mapper;
import kr.co.team4.model.dto.ReseravtionDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ReservationMapper {

    List<ReseravtionDTO> list(ReseravtionDTO dto);
}
