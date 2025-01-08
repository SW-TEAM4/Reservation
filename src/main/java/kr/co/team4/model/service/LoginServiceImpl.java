package kr.co.team4.model.service;

import kr.co.team4.model.SHA256;
import kr.co.team4.model.dto.SellerDTO;
import kr.co.team4.model.dto.UserDTO;
import kr.co.team4.model.mapper.LoginMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import java.util.Random;

import static java.security.spec.MGF1ParameterSpec.SHA256;

@Service
public class LoginServiceImpl implements LoginService {

    @Autowired
    private LoginMapper mapper;
//    @Autowired
//    private JavaMailSender mailSender;

    // 회원가입
    @Override
    public void userregister(UserDTO dto) throws Exception{
        try{
            // 비밀번호 암호화 (SHA-256만 사용)
            String encryptedPwd = new SHA256().encrypt(dto.getUSER_PWD());
            dto.setUSER_PWD(encryptedPwd);

        }catch (Exception e){
            e.printStackTrace();
            throw new Exception("비밀번호 암호화에 실패하였습니다."); // 에러 메시지 전달

        }

        mapper.userinsert(dto);
    }

    // 사장님 회원가입
    @Override
    public void sellerregister(SellerDTO dto) throws Exception {
        try{
            String encryptedPwd = new SHA256().encrypt(dto.getSELLER_PWD());
            dto.setSELLER_PWD(encryptedPwd);

        }catch (Exception e){
            e.printStackTrace();
            throw new Exception("비밀번호 암호화에 실패하였습니다.");
        }
        mapper.sellerinsert(dto);
    }

    // 아이디 중복 검사
    @Override
    public int ID_CHECK(String USER_ID) throws Exception {
        return mapper.ID_CHECK(USER_ID);
    }

    // 사장님 아이디 중복 검사
    @Override
    public int SELLER_ID_CHECK(String SELLER_ID) throws Exception {

        return mapper.SELLER_ID_CHECK(SELLER_ID);
    }

    // 로그인
    @Override
    public UserDTO userlogin(UserDTO dto) throws Exception {
        try {
            // 입력된 비밀번호를 SHA-256으로 암호화
            String encryptedPassword = new SHA256().encrypt(dto.getUSER_PWD());

            // 암호화된 비밀번호를 다시 dto에 설정
            dto.setUSER_PWD(encryptedPassword);

            // 로그인 시도
            return mapper.userlogin(dto);
        } catch (Exception e) {
            // 기타 예외 처리
            throw new Exception("로그인 처리 중 오류가 발생하였습니다.", e);
        }
    }

    // 사장님 로그인
    @Override
    public SellerDTO sellerlogin(SellerDTO dto) throws Exception {
        try{
            String encryptedPassword = new SHA256().encrypt(dto.getSELLER_PWD());
            dto.setSELLER_PWD(encryptedPassword);
            return mapper.sellerlogin(dto);

        }catch (Exception e){
            throw new Exception("로그인 처리 중 오류가 발생하였습니다.", e);
        }

    }

    // 이메일 전송
//    @Value("${smtp.username}")
//    private String smtpSenderName;
//
//    @Override
//    public void sendEmail(String USER_EMAIL) throws Exception {
//        SimpleMailMessage message = new SimpleMailMessage();
//        message.setTo(USER_EMAIL);
//        message.setSubject("같이가개 회원가입 인증 이메일입니다.");
//
//        // 난수의 범위 111111 ~ 999999(6자리 난수)
//        Random random = new Random();
//        int checkNum = random.nextInt(888888) + 111111;
//
//        message.setText("인증 번호는 " + checkNum + "입니다." + "\n" + "해당 인증 번호를 인증 번호 입력란에 입력해주세요.");
//        message.setFrom(smtpSenderName); // 발신자 이메일 주소
//
//        mailSender.send(message);
//
//        return checkNum;
//    }



}
