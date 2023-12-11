package lab.course.controller.auth;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
//
//Защищаемая часть
@WebFilter(urlPatterns = {"/user_profile.jsp"})
public class AccountFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException { }
    @Override
    public void destroy() { }

    @Override
    public void doFilter(ServletRequest servletRequest,
                         ServletResponse servletResponse,
                         FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        HttpSession session = request.getSession(false);

        //Существует ли сессиия
        boolean loggedIn = session != null &&
                session.getAttribute("login") != null &&
                session.getAttribute("role") != null;

        if (loggedIn) {
            //Если существует то получаем роль
            response.sendRedirect(request.getContextPath() + "/data");
            //Если нет то на страницу входа.
        } else response.sendRedirect(request.getContextPath() + "/login");
    }
}
