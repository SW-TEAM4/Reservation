package kr.co.team4.model.mapper;

import kr.co.team4.model.dto.LodgmentDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;


@Mapper
public interface LodgmentMapper {
    List<LodgmentDTO> lodgmentDetail(LodgmentDTO lodgmentDTO);
}
