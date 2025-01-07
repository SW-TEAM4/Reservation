package kr.co.team4.model;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;

import java.security.MessageDigest;

public class SHA256 {
    public SHA256() {}

    // 비밀번호 암호화 메서드 (SALT 없이 SHA-256만 사용)
    public static String encrypt(String plainText) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(plainText.getBytes()); // 비밀번호를 바이트 배열로 변환하여 업데이트
            byte[] byteData = md.digest(); // 해시 값을 계산

            // 계산된 바이트 데이터를 16진수로 변환하여 반환
            StringBuilder hexString = new StringBuilder();
            for (byte b : byteData) {
                String hex = Integer.toHexString(0xFF & b); // 바이트 값을 16진수로 변환
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            return hexString.toString(); // 최종적으로 암호화된 해시값 반환
        } catch (Exception e) {
            throw new RuntimeException("SHA-256 encryption failed", e);
        }
    }
}