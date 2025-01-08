package kr.co.team4.model.mapper;

import kr.co.team4.model.dto.LodLikeDTO;

import kr.co.team4.model.dto.LodgmentDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.math.BigInteger;
import java.util.List;

@Mapper
public interface LodLikeMapper {

    // 찜 추가
    int insertLike(LodLikeDTO lodLikeDTO);

    // 찜 삭제
    int deleteLike(@Param("user_idx") BigInteger user_idx, @Param("lod_idx") int lod_idx);

    // 특정 유저와 숙소 ID로 찜 상태 조회
    LodLikeDTO findByUserAndLod(LodLikeDTO dto);

    // 유저의 찜한 숙소 리스트 가져오기
    List<LodgmentDTO> getLikedLodgments(BigInteger userIdx);
}


