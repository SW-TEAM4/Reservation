package kr.co.team4.model.service.reservation;

import kr.co.team4.model.dto.ReseravtionDTO;
import kr.co.team4.model.mapper.ReservationMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.OptionalDouble;

@Service
public class ReservationServiceImpl implements ReservationService {
    @Autowired
    public ReservationMapper mapper;
    @Autowired
    public ReservationServiceImpl(ReservationMapper mapper){
        this.mapper = mapper;
    }

    @Override
    public Map<String, Object>list(ReseravtionDTO dto){
        List<ReseravtionDTO>list =mapper.list(dto);
        Map<String,Object> map = new HashMap<>();
        map.put("list",list);
        return map;
    }





}
