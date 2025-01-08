package kr.co.team4.model.service;

import kr.co.team4.model.dto.LodLikeDTO;
import kr.co.team4.model.dto.LodgmentDTO;
import kr.co.team4.model.mapper.LodLikeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.math.BigInteger;
import java.util.List;

@Service
public class LodLikeServiceImpl implements LodLikeService {

    @Autowired
    private LodLikeMapper lodLikeMapper;

    @Override
    public boolean toggleLike(LodLikeDTO lodLikeDTO) {
        try {
            // 기존 찜 상태 확인
            LodLikeDTO existing = lodLikeMapper.findByUserAndLod(lodLikeDTO);

            if (existing == null) { // 찜 추가
                System.out.println("찜 추가: USER_IDX = " + lodLikeDTO.getUser_idx() + ", lod_idx = " + lodLikeDTO.getLod_idx());
                lodLikeMapper.insertLike(lodLikeDTO);
                return true; // 추가됨
            } else { // 찜 제거
                System.out.println("찜 제거: USER_IDX = " + lodLikeDTO.getUser_idx() + ", lod_idx = " + lodLikeDTO.getLod_idx());
                lodLikeMapper.deleteLike(lodLikeDTO.getUser_idx(), lodLikeDTO.getLod_idx());
                return false; // 제거됨
            }
        } catch (Exception e) {
            e.printStackTrace(); // 예외 로그 출력
            throw new RuntimeException("찜 상태 토글 중 오류 발생", e);
        }
    }



    @Override
    public List<LodgmentDTO> getLikeList(BigInteger userIdx) {
        return lodLikeMapper.getLikedLodgments(userIdx);
    }

    @Override
    public LodLikeDTO findByUserAndLod(LodLikeDTO dto) {

        return lodLikeMapper.findByUserAndLod(dto);
    }
}




