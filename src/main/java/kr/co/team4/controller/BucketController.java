package kr.co.team4.controller;

import kr.co.team4.model.service.S3Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@Controller
public class BucketController {
    @Autowired
    private S3Service s3Service;

    @GetMapping("/common/gos3.do")
    public String move(){
        return "/common/s3test";
    }

    @PostMapping("/common/s3test.do")
    public String uploadFile(Model model, MultipartFile file, String imgKey) throws IOException {
        if(file == null || file.isEmpty()){
            model.addAttribute("msg", "파일이 비어 있음");
            model.addAttribute("cmd", "back");
        }
        else{
            boolean success = s3Service.uploadFileToS3(imgKey,file);

            if(success){
                model.addAttribute("msg", "정상적으로 S3 버킷에 이미지 업로드 완료");
                model.addAttribute("url", "/");

            }else{
                model.addAttribute("msg", "S3 버킷에 이미지 업로드 실패");
                model.addAttribute("url", "/");
            }
        }
        return "common/alert";
    }

    @GetMapping("/common/s3test.do")
    public String getFile(Model model, String imgKey){
        String imgUrl = s3Service.getFileFromS3(imgKey);
        model.addAttribute("imgUrl", imgUrl);
        return "/common/s3test";
    }

}
