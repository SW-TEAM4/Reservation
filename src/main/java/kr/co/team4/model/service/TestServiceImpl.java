package kr.co.team4.model.service;

import kr.co.team4.model.dto.TestDTO;
import kr.co.team4.model.mapper.TestMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class TestServiceImpl implements TestService {

    @Autowired
    private TestMapper mapper;

    @Override
    public int count(TestDTO vo) {
        return mapper.count(vo);
    }

    @Override
    public Map<String, Object> list(TestDTO dto) {
        List<TestDTO> list = mapper.list(dto);
        Map<String, Object> map = new HashMap<>();
        map.put("list", list);
        map.put("count", mapper.count(dto));
        return map;
    }
}
