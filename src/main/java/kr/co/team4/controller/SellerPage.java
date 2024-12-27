package kr.co.team4.controller;

import kr.co.team4.model.dto.lodRegisterDTO;
import kr.co.team4.model.service.lodRegisterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/lodgment")
public class SellerPage {
    /**
     * 생성자   : JDeok
     * 기 능   : 사장님 숙소등록 로직
     * 변경사항
     *  - 2024.12.26 : JDeok(최초생성)
     * */
    @Autowired //[check]
    private lodRegisterService lodRegisterService;

    @PostMapping("/insertLod.do")
    public String lodRegister(@ModelAttribute lodRegisterDTO dto) {
        dto.setSeller_idx(4);
        dto.setLod_img_url("");
        lodRegisterService.registerLod(dto);
        lodRegisterService.registerFacility(dto);
        return "redirect:/lodgment/sellerDetailMain";
    }
    /**
     * 생성자   : JDeok
     * 기 능   : 사장님 상세페이지 조회
     * 변경사항
     *  - 2024.12.24 : JDeok(최초생성)
     * */
    @GetMapping("/sellerDetailMain")
    public String sellerDetailMain(Model model) {
        model.addAttribute("pageTitle", "sellerDetailMain"); // 활성 메뉴 설정
        return "seller/sellerDetailMain";
    }

    /**
     * 생성자   : JDeok
     * 기 능   : 사장님 메인페이지 조회
     * 변경사항
     *  - 2024.12.23 : JDeok(최초생성)
     * */
    @GetMapping("/sellerMain.do")
    public String sellerMain() {
        /**
         * [check] 로그인상태인지 확인
         * 로그인 상태이면 들어올 필요 X
         */
        return "seller/sellerMain";
    }

    /**
     * 생성자   : JDeok
     * 기 능   : 사장님 숙소등록페이지 조회
     * 변경사항
     *  - 2024.12.23 : JDeok(최초생성)
     * */
    @GetMapping("/lodRegister.do")
    public String lodRegister() {
        return "seller/lodRegister";
    }

    /**
     * 생성자   : JDeok
     * 기 능   : 사장님 객실등록
     * 변경사항
     *  - 2024.12.24 : JDeok(최초생성)
     * */
    @GetMapping("/detailPage")
    public String detailPage() {
        return "seller/detailPage";
    }


}

