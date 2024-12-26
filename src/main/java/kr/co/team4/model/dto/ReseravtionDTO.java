package kr.co.team4.model.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import org.springframework.web.bind.annotation.GetMapping;

import java.sql.Date;
@Data
@Getter
@Setter
public class ReseravtionDTO {
    private int reservation_idx;
    private int lod_idx;
    private int room_idx;
    private int user_idx;
    private String res_name;
    private String res_phone_number;
    private Date res_str_date;
    private Date res_end_date;
    private String lod_img_url;
    private  int res_people_cnt;
    private String request;
    private String status;
    private String LOD_NAME;
}
