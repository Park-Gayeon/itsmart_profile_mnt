package kr.co.itsmart.profileMnt.service;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import kr.co.itsmart.profileMnt.configuration.security.provider.JwtService;
import kr.co.itsmart.profileMnt.dao.CommonDAO;
import kr.co.itsmart.profileMnt.vo.LoginVO;
import kr.co.itsmart.profileMnt.vo.auth.AuthResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.Map;

@Service
public class LoginServiceImpl implements LoginService {
    private static final Logger LOGGER = LoggerFactory.getLogger(ProfileInfoServiceImpl.class);
    private final AuthenticationManager authenticationManager;
    private final JwtService jwtService;

    private final CommonDAO commonDAO;

    public LoginServiceImpl(AuthenticationManager authenticationManager
            , JwtService jwtService
            , CommonDAO commonDAO) {
        this.authenticationManager = authenticationManager;
        this.jwtService = jwtService;
        this.commonDAO = commonDAO;
    }

    @Override
    @Transactional
    public AuthResponse authenticate(LoginVO user) {
        LOGGER.info("[Login] user_id : {}", user.getUser_id());
        try {
            // [인증]
            authenticationManager.authenticate(
                    // 1.   AuthenticationProvider 호출 : 인증 작업을 수행
                    // 1-1. DaoAuthenticationProvider 를 사용
                    // 1-2. UserDetailsService 호출 : UserDetails 객체 반환(사용자ID, 암호화된 PW)
                    // 1-3. DaoAuthenticationProvider 에서 비밀번호를 검증( UserDetails PW랑, 입력된 PW 비교 )
                    // 2.   인증성공 Authentication 반환
                    new UsernamePasswordAuthenticationToken(user.getUser_id(), user.getUser_pw())
            );
            // [발급] access token, refresh token
            String accessToken = jwtService.generateToken(user);
            String refreshToken = jwtService.generateRefreshToken(user);

            // DB에 refresh token 저장
            try {
                // 최초 로그인 시 기존의 모든 refresh token 삭제
                LOGGER.info("USER_ID :{} 인 REFRESH_TOKEN 삭제", user.getUser_id());
                commonDAO.removeUsrRefreshToken(user.getUser_id());

                Map<String, String> params = new HashMap<>();
                params.put("user_id", user.getUser_id());
                params.put("refreshToken", refreshToken);
                LOGGER.info("USER_ID :{} 인 REFRESH_TOKEN 저장", user.getUser_id());
                commonDAO.saveUsrRefreshToken(params);
            } catch (Exception e) {
                LOGGER.error("REFRESH_TOKEN 삭제 및 저장 중 오류 발생 : {}", e.getMessage());
                throw e;
            }
            return new AuthResponse(accessToken, refreshToken);
        } catch (BadCredentialsException e) {
            LOGGER.error("[authenticationManager.authenticate] 비밀번호 불일치");
            throw e;
        } catch (UsernameNotFoundException e) {
            LOGGER.error("[authenticationManager.authenticate] 사용자를 찾을 수 없습니다.");
            throw e;
        }
    }

    @Override
    public String getAccessTokenCookies(HttpServletRequest request) {
        if (request.getCookies() != null) {
            for (Cookie cookie : request.getCookies()) {
                if ("accessToken".equals(cookie.getName())) {
                    return cookie.getValue();
                }
            }
        }
        return null;
    }
}
