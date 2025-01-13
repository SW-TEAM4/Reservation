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
        session.setMaxInactiveInterval(60 * 60);
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent httpSessionEvent) {
    }
}
