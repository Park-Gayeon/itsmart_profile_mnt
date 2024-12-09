package kr.co.itsmart.profileMnt.configuration.security.filter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.itsmart.profileMnt.configuration.security.provider.JwtService;
import kr.co.itsmart.profileMnt.dao.CommonDAO;
import kr.co.itsmart.profileMnt.service.LoginService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@Component
public class JwtAuthenticationFilter extends OncePerRequestFilter {
    private final Logger logger = LoggerFactory.getLogger(this.getClass());
    private final JwtService jwtService;
    private final UserDetailsService userDetailsService;
    private final LoginService loginService;
    private final CommonDAO commonDAO;

    public JwtAuthenticationFilter(JwtService jwtService
            , UserDetailsService userDetailsService
            , @Lazy LoginService loginService
            , @Lazy CommonDAO commonDAO) {
        this.jwtService = jwtService;
        this.userDetailsService = userDetailsService;
        this.loginService = loginService;
        this.commonDAO = commonDAO;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        final String token;
        final String user_id; // username

        // access token 확인
        String accessToken = loginService.getAccessTokenCookies(request);
        if(accessToken != null){
            token = accessToken;
            logger.info("[doFilterInternal - cookie] accessToken : {}", accessToken);
        } else {
            token = null;
            logger.info("[doFilterInternal - cookie] accessToken : null");
        }
        try {
            if (token != null) {
                user_id = jwtService.extractUsername(token);

                // usename 이 존재하는데 인증정보가 없다면 사용자를 조회한다
                if (user_id != null && SecurityContextHolder.getContext().getAuthentication() == null) {
                    UserDetails userDetails = userDetailsService.loadUserByUsername(user_id);

                    // token 정보와 조회된 사용자를 검증하고 결과값이 true 라면 인증정보 설정
                    if (jwtService.isTokenValid(token, userDetails)) {
                        logger.info("[isTokenValid - access token] 유효성 검사 통과");

                        setAuthentication(userDetails);

                    } else {
                        // access token expired
                        String refreshToken = commonDAO.getUsrRefreshToken(user_id);
                        logger.info("[refresh token] :{}", refreshToken);
                        if(refreshToken != null){
                            if(jwtService.isTokenValid(refreshToken, userDetails)){
                                logger.info("[isTokenValid - refresh token] 유효성 검사 통과");

                                // get new access token
                                String newAccessToken = jwtService.generateAccessToken(userDetails);
                                logger.info("[refresh token] : {}", newAccessToken);

                                Cookie accessTokenCookie = setCookie(newAccessToken);
                                response.addCookie(accessTokenCookie);

                                setAuthentication(userDetails);
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            logger.info("[doFilterInternal] : {}", e.getMessage());
            return;
        }
        logger.info("[filterChain.doFilter] 동작]");
        filterChain.doFilter(request, response);
    }

    private void setAuthentication(UserDetails userDetails){
        // SecurityContext 에 인증 정보 추가
        UsernamePasswordAuthenticationToken authToken =
                new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
        SecurityContextHolder.getContext().setAuthentication(authToken);
    }

    private Cookie setCookie(String token){
        // set Cookie
        Cookie accessTokenCookie = new Cookie("accessToken", token);
        accessTokenCookie.setHttpOnly(true);
        accessTokenCookie.setPath("/");
        accessTokenCookie.setMaxAge(60 * 10);      // 10 min

        return accessTokenCookie;
    }
}
