package kr.co.team4.controller;

import kr.co.team4.model.dto.BoardDTO;
import kr.co.team4.model.dto.CommentDTO;
import kr.co.team4.model.dto.CommentResDTO;
import kr.co.team4.model.dto.UserDTO;
import kr.co.team4.model.service.BoardService;
import org.apache.ibatis.annotations.Param;
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
        List<CommentResDTO> commentResDTOList = boardService.selectComment(BOARD_IDX);
        model.addAttribute("commentResDTOList", commentResDTOList);
        return "board/detail";
    }


    @PostMapping("/comment/write")
    public String PostComment(@ModelAttribute CommentResDTO commentResDTO, HttpSession session, @RequestParam("BOARD_IDX") int BOARD_IDX) throws Exception {
        // 세션에서 사용자 정보 가져오기
        UserDTO usersession = (UserDTO) session.getAttribute("usersession");

        // 로그인하지 않은 경우 리디렉션
        if (usersession == null) {
            System.out.println("No Session.");
            return "redirect:/userlogin";
        }

        // 사용자 ID 가져오기
        BigInteger userIdx = usersession.getUSER_IDX();

        // 세션에 사용자 ID가 없을 경우 리디렉션
        if (userIdx == null) {
            System.out.println("No Session USER_IDX.");
            return "redirect:/userlogin";
        }

        // 댓글 DTO에 사용자 정보 설정
        commentResDTO.setUSER_IDX(userIdx);
        commentResDTO.setBOARD_IDX(BigInteger.valueOf(BOARD_IDX));  // 게시글 번호 설정

        // 댓글 삽입 서비스 호출
        boardService.insertComment(commentResDTO);

        // 댓글 작성 후 동일한 게시글 상세보기 페이지로 리디렉션
        return "redirect:/detail?BOARD_IDX=" + BOARD_IDX;
    }


}
