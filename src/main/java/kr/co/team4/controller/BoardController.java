package kr.co.team4.controller;

import kr.co.team4.model.dto.BoardDTO;
import kr.co.team4.model.dto.UserDTO;
import kr.co.team4.model.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.math.BigInteger;
import java.util.List;

@Controller
public class BoardController {

    @Autowired
    private BoardService boardService;

    @GetMapping("/gather")
    public String list(Model model) throws Exception{
        List<BoardDTO> boardList = boardService.getBoardList();
        model.addAttribute("list", boardList);
        return "board/gather";
    }

    @GetMapping("/write")
    public String showWriteForm() {
        return "board/write";
    }

    @PostMapping("/write")
    public String writepost(@ModelAttribute BoardDTO board, HttpSession session) throws Exception {
        UserDTO usersession = (UserDTO) session.getAttribute("usersession");
        if(usersession == null) {
            System.out.println("No Session.");
            return "redirect:/userlogin";
        }

        BigInteger USER_IDX = usersession.getUSER_IDX();
        if(USER_IDX == null) {
            System.out.println("No Session USER_IDX.");
            return "redirect:/userlogin";
        }

        System.out.println("세션 USER_IDX : " + USER_IDX);
        board.setUSER_IDX(USER_IDX);

        boardService.write(board);

        return "redirect:/gather";
    }

    @GetMapping("/detail")
    public String detail(@RequestParam("BOARD_IDX") int BOARD_IDX, Model model) throws Exception {
        BoardDTO detail = boardService.detail(BOARD_IDX);
        model.addAttribute("detail", detail);
        return "board/detail";
    }


}
