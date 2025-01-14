package filter;

import javax.servlet.ServletContext;
import javax.servlet.ServletRequest;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Map;

public class SessionListener implements HttpSessionListener {

    @Override
    public void sessionCreated(HttpSessionEvent httpSessionEvent) {
        HttpSession session = httpSessionEvent.getSession();
        // 세션 유지 시간 1시간
//        session.setMaxInactiveInterval(60 * 60);
        System.out.println("새로운 세션 생성: 세션 ID: " + session.getId());
        session.setMaxInactiveInterval(30);
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent httpSessionEvent) {
        HttpSession session = httpSessionEvent.getSession();
        System.out.println("세션이 종료되었습니다. 세션 ID: " + session.getId());
    }
}
