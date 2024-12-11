package kr.co.team4.model.service;

import kr.co.team4.model.dto.TestDTO;

import java.util.Map;

public interface TestService {
    Map<String, Object> list(TestDTO dto);
    int count(TestDTO vo);
}
