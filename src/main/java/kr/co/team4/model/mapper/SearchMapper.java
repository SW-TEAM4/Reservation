package kr.co.team4.model.mapper;

import kr.co.team4.model.dto.LodgmentDTO;
import kr.co.team4.model.dto.SearchFilterDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface SearchMapper {
    List<LodgmentDTO> searchLodgments(SearchFilterDTO filter);
}
