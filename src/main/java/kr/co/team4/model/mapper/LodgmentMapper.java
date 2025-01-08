package kr.co.team4.model.mapper;

import kr.co.team4.model.dto.LodgmentDTO;
import kr.co.team4.model.dto.RoomDTO;
import kr.co.team4.model.dto.SellerDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface LodgmentMapper {
    LodgmentDTO lodgmentDetail(LodgmentDTO lodgmentDTO);
    SellerDTO getSellerInfo(int lod_idx);
    List<RoomDTO> getAvailableRooms(Map<String, Object> params);
}
