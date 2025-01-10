package Interceptor;

import com.fasterxml.jackson.databind.ObjectMapper;
import kr.co.team4.model.dto.SellerDTO;
import kr.co.team4.model.service.SellerPageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.math.BigInteger;

/**
 * 생성자   : JDeok
 * 기 능   : 세션체크 및 숙소명 보여주기
 * 변경사항
 * - 2025.01.10  : JDeok(최초생성)
 */

@Component
public class CommonDataInterceptor implements HandlerInterceptor {

    @Autowired
    private SellerPageService sellerPageService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        Object sellerSession = session.getAttribute("sellersession");

        if (sellerSession != null) {
            String lodgmentName = (String) session.getAttribute("lodgmentName");
            if (lodgmentName == null) {

                SellerDTO seller = (SellerDTO) sellerSession;
                int seller_idx = seller.getSELLER_IDX().intValue();

                Integer lod_idx = sellerPageService.getLod(seller_idx);
                if (lod_idx != null && lod_idx > 0) {
                    lodgmentName = sellerPageService.getLodgmentName(lod_idx);
                    session.setAttribute("lodgmentName", lodgmentName);
                }
            }
            request.setAttribute("lodgmentName", lodgmentName); // JSP에서 사용할 데이터
        }
        return true;
    }
}


