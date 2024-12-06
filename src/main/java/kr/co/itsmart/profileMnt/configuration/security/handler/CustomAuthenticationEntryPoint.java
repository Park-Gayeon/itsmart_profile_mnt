package kr.co.itsmart.profileMnt.configuration.security.handler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;

import java.io.IOException;
@Component
public class CustomAuthenticationEntryPoint implements AuthenticationEntryPoint {
    private Logger logger = LoggerFactory.getLogger(this.getClass());
    @Override
    public void commence(HttpServletRequest request, HttpServletResponse response, AuthenticationException authException) throws IOException, ServletException {
        logger.info("[CustomAuthenticationEntryPoint] :: {}", authException.getMessage());
        logger.info("[CustomAuthenticationEntryPoint] :: {}", request.getRequestURL());
        logger.info("[CustomAuthenticationEntryPoint] :: 인증된 사용자가 아닙니다.");

        response.sendRedirect("/auth/login/main");
    }
}
