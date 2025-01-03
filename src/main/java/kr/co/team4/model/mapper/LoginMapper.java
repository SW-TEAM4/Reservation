package kr.co.team4.model.mapper;

import kr.co.team4.model.dto.SellerDTO;
import kr.co.team4.model.dto.UserDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface LoginMapper {
    // 사용자 회원가입
    public void userinsert(UserDTO dto);

    // 사장님 회원가입
    public void sellerinsert(SellerDTO dto);

    // 아이디 중복 검사
    public int ID_CHECK(String USER_ID);

    // 사장님 아이디 중복 검사
    public int SELLER_ID_CHECK(String SELLER_ID);

    // 로그인
    public UserDTO userlogin(UserDTO dto);

    // 사장님 로그임
    public SellerDTO sellerlogin(SellerDTO dto);

}
