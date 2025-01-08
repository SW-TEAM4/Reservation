package kr.co.team4.model.service;

import kr.co.team4.model.dto.*;
import java.math.BigInteger;
import java.util.List;


public interface LodLikeService {

    // 찜 상태 토글
    boolean toggleLike(LodLikeDTO lodLikeDTO);

    // 찜한 숙소 리스트 가져오기
    List<LodgmentDTO> getLikeList(BigInteger userIdx);

    LodLikeDTO findByUserAndLod(LodLikeDTO dto);
}

