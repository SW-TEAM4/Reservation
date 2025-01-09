package filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginSessionFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain filterChain) throws IOException, ServletException {

        // HttpServletRequest로 형변환
        HttpServletRequest httpRequest = (HttpServletRequest) request;

        // 세션 가져오기
        HttpSession session = httpRequest.getSession(false); // 세션이 존재하지 않으면 null 반환

        // /userlogin 경로는 필터에서 제외
        if (httpRequest.getRequestURI().equals("common/alert")) {
            filterChain.doFilter(request, response);
            return;
        }

        if (session == null || session.getAttribute("usersession") == null) {

            // 현재 요청 URL과 GET 파라미터를 세션에 저장
            String requestedUrl = httpRequest.getRequestURL().toString();
            String queryString = httpRequest.getQueryString();  // 쿼리 파라미터 가져오기
            // 쿼리 파라미터 존재하는 경우만 추가로 더해서 기억
            String returnUrl = (queryString != null) ? requestedUrl + "?" + queryString : requestedUrl;
            session.setAttribute("redirectUrl", returnUrl);

            request.setAttribute("msg", "로그인이 필요합니다");
            // 세션에 사용자 정보가 없으면 로그인 페이지로 리다이렉트
            request.getRequestDispatcher("/userlogin").forward(request, response);
        } else {
            // 세션에 사용자 정보가 있으면 다음 필터 또는 서블릿으로 진행
            filterChain.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {

    }
}
