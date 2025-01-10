package Interceptor;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 생성자   : JDeok
 * 기 능   : 세션체크 및 숙소명 보여주기
 * 변경사항
 * - 2025.01.10  : JDeok(최초생성)
 */
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Component
public class SellerInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        Object userSession = session.getAttribute("sellersession");

/*        // 로그인 상태가 아니면 로그인 페이지로 리다이렉트
        if (userSession == null) {
            response.sendRedirect("/auth/login");
            return false; // 요청 진행 중단
        }*/

        // 로그인 상태면 요청 계속 진행
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        // 컨트롤러 처리 후, 뷰 렌더링 전에 실행
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        // 뷰 렌더링 후 실행 (리소스 정리 등에 사용)
    }
}

