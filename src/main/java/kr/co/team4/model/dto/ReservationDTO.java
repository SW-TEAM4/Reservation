package kr.co.team4.model.dto;

import lombok.Data;

import java.math.BigInteger;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@Data
public class ReservationDTO {
    private BigInteger reservation_idx;
    private BigInteger lod_idx;
    private BigInteger room_idx;
    private BigInteger user_idx;
    private String res_merchant_id;
    private String res_name;
    private String res_phone_number;
    private String res_str_date;
    private String res_end_date;
    private int res_people_cnt;
    private int res_pets_cnt;
    private String request;
    private String status;

    public String getDateDifferenceDays() throws ParseException {
        // 두 날짜 차이 계산
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date res_str = dateFormat.parse(res_str_date);
        Date res_end = dateFormat.parse(res_end_date);
        long differenceInMilliseconds = res_end.getTime() - res_str.getTime();

        // 밀리초를 일수로 변환
        long differenceInDays = differenceInMilliseconds / (1000 * 60 * 60 * 24);

        // 차이를 문자열로 반환
        return differenceInDays + "박";
    }

}

