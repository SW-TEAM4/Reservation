package kr.co.team4.model.service;

import kr.co.team4.model.dto.SellerDTO;
import kr.co.team4.model.dto.UserDTO;

public interface LoginService {
    // 사용자 회원가입
    public void userregister(UserDTO dto) throws Exception;

    // 사장님 회원가입
    public void sellerregister(SellerDTO dto) throws Exception;

    // 로그인
    public UserDTO userlogin(UserDTO dto) throws Exception;

    // 사장님 로그인
    public SellerDTO sellerlogin(SellerDTO dto) throws Exception;

    // 아이디 중복 검사
    public int ID_CHECK(String USER_ID) throws Exception;

    // 사장님 아이디 중복 검사
    public int SELLER_ID_CHECK(String SELLER_ID) throws Exception;


}
