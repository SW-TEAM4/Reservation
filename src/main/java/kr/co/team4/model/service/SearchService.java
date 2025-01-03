package kr.co.team4.model.service;

import kr.co.team4.model.dto.LodgmentDTO;
import kr.co.team4.model.dto.SearchFilterDTO;

import java.util.List;

public interface SearchService {
    List<LodgmentDTO> searchLodgments(SearchFilterDTO filter);
}
