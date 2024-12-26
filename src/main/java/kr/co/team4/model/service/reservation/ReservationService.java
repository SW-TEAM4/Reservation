package kr.co.team4.model.service.reservation;
import kr.co.team4.model.dto.ReseravtionDTO;

import java.util.List;
import java.util.Map;

public interface ReservationService {

    Map<String, Object> list(ReseravtionDTO dto);

}
