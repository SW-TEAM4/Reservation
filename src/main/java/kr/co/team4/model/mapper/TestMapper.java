package kr.co.team4.model.mapper;

import kr.co.team4.model.dto.TestDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface TestMapper {
    List<TestDTO> list(TestDTO dto);
    int count(TestDTO vo);
}
