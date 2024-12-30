package kr.co.team4.model.mapper;

import kr.co.team4.model.dto.LodFacilityDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;


@Mapper
public interface LodFacilityMapper {
    List<LodFacilityDTO> getFacilityList(int lod_idx);  // lod_idx만 받아서 사용하는 방법
}
