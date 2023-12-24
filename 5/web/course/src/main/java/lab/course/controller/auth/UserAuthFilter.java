package lab.course.controller.auth;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
//Все страницы сайта обрабатывает данный фильтр
@WebFilter(urlPatterns = {"/*"})
public class UserAuthFilter implements Filter {
    String[] path = {"/register.jsp", "/user/index.jsp","/user/order.jsp",
            "/user/orders.jsp", "/login", "/orders", "/order", "/data", "/logout",
            "/account","/register"};
    @Override
    public void init(FilterConfig filterConfig) throws ServletException { }

    @Override
    public void destroy() { }

    @Override
    public void doFilter(ServletRequest servletRequest,
                         ServletResponse servletResponse,
                         FilterChain filterChain) throws IOException, ServletException {

        //получение данных сессии
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        HttpSession session = request.getSession(false);

        //URL Запроса/переадресации на Servlet входа
        String loginURI = "/login";

        //Если сессия ранее создана
        boolean loggedIn = session != null &&
                session.getAttribute("login") != null &&
                session.getAttribute("role").equals("user");

        int loginRequest = 0;
        for (var a: path) {
            if (request.getRequestURI().contains(a)) loginRequest = 1;
        }
        //Если запрос пришел со страницы с входом или сессия не пуста даем добро следовать дальше
        //Если нет ридерект на страницу входа
        if (loggedIn) {
            if (loginRequest == 1) {
                filterChain.doFilter(request, response);
            } else {
                response.sendRedirect(loginURI);
            }
        } else{
            filterChain.doFilter(request, response);
        }
    }
}
