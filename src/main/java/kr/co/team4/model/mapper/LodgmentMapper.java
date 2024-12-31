package kr.co.team4.model.mapper;

import kr.co.team4.model.dto.LodgmentDTO;
import kr.co.team4.model.dto.RoomDTO;
import kr.co.team4.model.dto.SellerDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface LodgmentMapper {
    List<LodgmentDTO> lodgmentDetail(LodgmentDTO lodgmentDTO);
    List<RoomDTO> getRoomsByLodgment(int lodIdx);
    SellerDTO getSellerInfo(int lodIdx);
    List<RoomDTO> getAvailableRooms(Map<String, Object> params);
}
