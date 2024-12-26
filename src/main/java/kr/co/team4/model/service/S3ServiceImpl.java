package kr.co.team4.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.GetObjectRequest;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

import java.io.File;
import java.io.IOException;

@Service
public class S3ServiceImpl implements S3Service {
    /*
    * 아마존 S3 관련 서비스 메소드들을 구현한 클래스
    *
    * method: uploadFileToS3
    * param: String imgKey, File file
    * 기능: 아마존 S3에 생성한 버킷에 이미지 파일 업로드 기능 수행
    * bucketName -> aws s3에 생성한 버킷 이름 ex.우리의 경우 sdgb , bucekt.properties 파일에서 읽어옴
    * imgKey -> 이미지를 구분하는 고유한 키 , 이미지의 경로로도 생성 가능
    * file -> 저장할 이미지 파일
    *
    */

    @Autowired
    private S3Client s3Client;


    @Value("${bucket.name}")
    private String bucketName;
    @Value("${bucket.region}")
    private String bucketRegion;

    @Override
    public boolean uploadFileToS3(String imgKey, MultipartFile file) {
        try {
            PutObjectRequest putObjectRequest = PutObjectRequest.builder()
                    .bucket(bucketName)
                    .key(imgKey)
                    .build();

            s3Client.putObject(putObjectRequest, RequestBody.fromBytes(file.getBytes()));
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public String getFileFromS3(String imgKey) {
        // S3의 이미지 파일 URL 생성
        String url = String.format("https://%s.s3.%s.amazonaws.com/%s", bucketName, bucketRegion, imgKey);
        return url;
    }
}
