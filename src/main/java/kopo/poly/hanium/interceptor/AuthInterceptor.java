package kopo.poly.hanium.interceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.servlet.HandlerInterceptor;

public class AuthInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response,
                             Object handler) throws Exception {

        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("SS_USER_ID");

        if (userId == null || userId.isEmpty()) {
            response.sendRedirect("/user/login");
            return false;
        }

        return true;
    }
}
