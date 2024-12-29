package kr.co.team4.model.mapper;

import kr.co.team4.model.dto.LodgmentDTO;
import kr.co.team4.model.dto.SearchFilterDTO;

import java.util.List;

public interface SearchMapper {
    List<LodgmentDTO> searchLodgments(SearchFilterDTO filter);
}
