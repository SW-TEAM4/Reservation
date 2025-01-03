package kr.co.team4.model.service;

import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;

public interface S3Service {
    public boolean uploadFileToS3(String imageKey, MultipartFile file) throws IOException;
    public String getFileFromS3(String fileName);
}
