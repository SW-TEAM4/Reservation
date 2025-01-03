package kr.co.team4.model.dto;

import lombok.Data;

import java.math.BigInteger;
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
    private Date res_str_date;
    private Date res_end_date;
    private int res_people_cnt;
    private int res_pets_cnt;
    private String request;
    private String status;

    public String getFormattedCheckinDate(){
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        return dateFormat.format(res_str_date);
    }
    public String getFormattedCheckoutDate(){
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        return dateFormat.format(res_end_date);
    }
    public String getDateDifferenceDays(){
        // 두 날짜 차이 계산
        long differenceInMilliseconds = res_end_date.getTime() - res_str_date.getTime();

        // 밀리초를 일수로 변환
        long differenceInDays = differenceInMilliseconds / (1000 * 60 * 60 * 24);

        // 차이를 문자열로 반환
        return differenceInDays + "박";
    }

}

