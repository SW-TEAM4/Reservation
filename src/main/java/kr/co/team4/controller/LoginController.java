package kr.co.team4.controller;

import kr.co.team4.model.dto.SellerDTO;
import kr.co.team4.model.dto.UserDTO;
import kr.co.team4.model.service.LoginService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Random;

@Controller
public class LoginController {
    private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

    @Autowired
    private LoginService service;


    @GetMapping("/userregister")
    public String showUserRegisterForm() {
        logger.info("사용자 회원가입 페이지 진입");
        return "login/userregister";
    }

    @GetMapping("/sellerregister")
    public String showSellerRegisterForm() {
        logger.info("사장님 회원가입 페이지 진입");
        return "login/sellerregister";
    }

    @PostMapping("/userregister")
    public String UserRegister(UserDTO dto) throws Exception {
        logger.info("사용자 회원가입 진입");

        // 회원가입 서비스 실행
        service.userregister(dto);

        logger.info("register Service 성공");

        return "login/userlogin";
    }

    @PostMapping("/sellerregister")
    public String SellerRegister(SellerDTO dto) throws Exception {
        logger.info("사장님 회원가입 진입");

        service.sellerregister(dto);

        logger.info("register Service 성공");

        return "sellersuccess";
    }

    @GetMapping("/userlogin")
    public String showLoginForm() {
        logger.info("로그인 페이지 진입");
        return "login/userlogin";
    }

    @GetMapping("/sellerlogin")
    public String showSellerLoginForm() {
        logger.info("사장님 로그인 페이지 진입");
        return "login/sellerlogin";
    }

    @PostMapping("/userlogin")
    public String userlogin(HttpServletRequest request, UserDTO dto, RedirectAttributes rttr) throws Exception{

        HttpSession session = request.getSession();
        UserDTO user = service.userlogin(dto);

        if(user == null) { // 일치하지 않는 아이디, 비밀번호 입력(로그인 실패)
            int result = 0;
            rttr.addFlashAttribute("result", result);
            return "redirect:/userlogin";
        }

        session.setAttribute("usersession", user); // 일치하는 아이디, 비밀번호 입력(로그인 성공)

        return "login/main";
    }

    @PostMapping("/sellerlogin")
    public String sellerlogin(HttpServletRequest request, SellerDTO dto, RedirectAttributes rttr) throws Exception{

        HttpSession session = request.getSession();
        SellerDTO seller = service.sellerlogin(dto);

        if(seller == null) { // 일치하지 않는 아이디, 비밀번호 입력(로그인 실패)
            int result = 0;
            rttr.addFlashAttribute("result", result);
            return "redirect:/sellerlogin";
        }

        session.setAttribute("sellersession", seller); // 일치하는 아이디, 비밀번호 입력(로그인 성공)

        return "login/main";
    }

    @GetMapping("/main")
    public String main(HttpSession session, Model model) {
        UserDTO dto = (UserDTO) session.getAttribute("dto");
        if(dto == null) {
            return "redirect:login/userlogin";
        }
        model.addAttribute("dto", dto);
        return "login/main";
    }

//    @GetMapping("/dupUSER_ID")
//    public ResponseEntity<Map<String, Boolean>> dupUSER_ID(@RequestParam String USER_ID) {
//        boolean exists = service.dupUSER_ID(USER_ID);
//        Map<String, Boolean> response = new HashMap<>();
//        response.put("exists", exists);
//        return ResponseEntity.ok(response);
//    }

    @PostMapping("/ID_CHECK")
    @ResponseBody
    public String ID_CHECK(String USER_ID) throws Exception {
        logger.info("ID_CHECK() 진입");

        int result = service.ID_CHECK(USER_ID);

        logger.info("결과값 : " + result);

        if(result != 0) {
            return "fail"; // 중복아이디가 존재
        } else {
            return "success";
        }
    }

    @PostMapping("/SELLER_ID_CHECK")
    @ResponseBody
    public String SELLER_ID_CHECK(String SELLER_ID) throws Exception {
        logger.info("SELLER_ID_CHECK() 진입");

        int result = service.SELLER_ID_CHECK(SELLER_ID);

        logger.info("결과값 : " + result);

        if(result != 0) {
            return "fail"; // 중복아이디가 존재
        } else {
            return "success";
        }
    }

    //이메일 인증번호 전송
    @Autowired
    private JavaMailSender mailSender;

    @PostMapping("/user_email_auth")
    @ResponseBody
    public int UseremailAuth(String USER_EMAIL) {
        logger.info("전달 받은 이메일 주소 : " + USER_EMAIL);

//         난수의 범위 111111 ~ 999999(6자리 난수)
        Random random = new Random();
        int checkNum = random.nextInt(888888) + 111111;
//
//        // 이메일 보낼 양식
        String setFrom = "hjm8565@naver.com"; // 2단계 인증 x, 메일 설정에서 POP/IMAP 설정에서 POP/SMTP 사용함으로 설정
        String toMail = USER_EMAIL;
        String title = "같이가개 회원가입 인증 이메일입니다.";
        String content = "인증 번호는 " + checkNum + "입니다." + "<br>" + "해당 인증 번호를 인증 번호 확인란에 입력해주세요.";

        try {
//            service.sendEmail(USER_EMAIL);
            MimeMessage msg = mailSender.createMimeMessage(); // Spring에서 제공하는 mail API
            MimeMessageHelper helper = new MimeMessageHelper(msg, true, "utf-8");

            helper.setFrom(setFrom);
            helper.setTo(toMail);
            helper.setSubject(title);
            helper.setText(content, true);

            mailSender.send(msg);
            logger.info("메일 전송 성공");
        } catch (Exception e) {
            logger.error("메일 전송 중 오류 발생 : ", e);
            e.printStackTrace();
        }

        logger.info("랜덤 숫자 : " + checkNum);
        return checkNum;

    }

    @PostMapping("/seller_email_auth")
    @ResponseBody
    public int SelleremailAuth(String SELLER_EMAIL) {
        logger.info("전달 받은 이메일 주소 : " + SELLER_EMAIL);

//         난수의 범위 111111 ~ 999999(6자리 난수)
        Random random = new Random();
        int checkNum = random.nextInt(888888) + 111111;
//
//        // 이메일 보낼 양식
        String setFrom = "hjm8565@naver.com"; // 2단계 인증 x, 메일 설정에서 POP/IMAP 설정에서 POP/SMTP 사용함으로 설정
        String toMail = SELLER_EMAIL;
        String title = "같이가개 회원가입 인증 이메일입니다.";
        String content = "인증 번호는 " + checkNum + "입니다." + "<br>" + "해당 인증 번호를 인증 번호 확인란에 입력해주세요.";

        try {
//            service.sendEmail(USER_EMAIL);
            MimeMessage msg = mailSender.createMimeMessage(); // Spring에서 제공하는 mail API
            MimeMessageHelper helper = new MimeMessageHelper(msg, true, "utf-8");

            helper.setFrom(setFrom);
            helper.setTo(toMail);
            helper.setSubject(title);
            helper.setText(content, true);

            mailSender.send(msg);
            logger.info("메일 전송 성공");
        } catch (Exception e) {
            logger.error("메일 전송 중 오류 발생 : ", e);
            e.printStackTrace();
        }

        logger.info("랜덤 숫자 : " + checkNum);
        return checkNum;

    }

//    @GetMapping("/EMAIL_CHECK")
//    @ResponseBody
//    public void emailCheck(String USER_EMAIL) throws Exception{
//
//        // 인증번호 난수 생성
//        Random random = new Random();
//        int checkNum = random.nextInt(888888) + 111111;
//
//        // 이메일 전송
//        String setFrom = "hjm8565@naver.com";
//        String toMail = USER_EMAIL;
//        String title = "같이가개 회원가입 인증 이메일입니다.";
//        String content = "인증 번호는 " + checkNum + "입니다." + "<br>" + "해당 인증 번호를 인증 번호 입력란에 입력해주세요.";
//
//        try {
//            MimeMessage msg = mailSender.createMimeMessage();
//            MimeMessageHelper helper = new MimeMessageHelper(msg, true, "utf-8");
//            helper.setFrom(setFrom);
//            helper.setTo(toMail);
//            helper.setSubject(title);
//            helper.setText(content, true);
//            mailSender.send(msg);
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//    }

}
