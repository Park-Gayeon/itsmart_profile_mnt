package kr.co.itsmart.profileMnt.configuration.security.handler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Component
public class CustomAccessDeniedHandler implements AccessDeniedHandler {
    private Logger logger = LoggerFactory.getLogger(this.getClass());
    @Override
    public void handle(HttpServletRequest request, HttpServletResponse response, AccessDeniedException accessDeniedException) throws IOException, ServletException {
        logger.info("[CustomAccessDeniedHandler] :: {}", accessDeniedException.getMessage());
        logger.info("[CustomAccessDeniedHandler] :: {}", request.getRequestURL());
        logger.info("[CustomAccessDeniedHandler] :: 토큰 정보가 만료되었거나 존재하지 않습니다.");

        response.sendRedirect("/auth/login/main");
    }
}
