package kr.co.itsmart.profileMnt.service;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import kr.co.itsmart.profileMnt.configuration.handler.CustomException;
import kr.co.itsmart.profileMnt.configuration.security.provider.JwtService;
import kr.co.itsmart.profileMnt.dao.CommonDAO;
import kr.co.itsmart.profileMnt.vo.LoginVO;
import kr.co.itsmart.profileMnt.vo.auth.AuthResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.Map;

@Service
public class LoginServiceImpl implements LoginService {
    private final Logger LOGGER = LoggerFactory.getLogger(this.getClass());
    private final AuthenticationManager authenticationManager;
    private final PasswordEncoder passwordEncoder;
    private final JwtService jwtService;

    private final CommonDAO commonDAO;

    public LoginServiceImpl(AuthenticationManager authenticationManager
            , PasswordEncoder passwordEncoder
            , JwtService jwtService
            , CommonDAO commonDAO) {
        this.authenticationManager = authenticationManager;
        this.passwordEncoder = passwordEncoder;
        this.jwtService = jwtService;
        this.commonDAO = commonDAO;
    }

    @Override
    @Transactional
    public AuthResponse authenticate(LoginVO user) {
        LOGGER.info("[Login] user_id : {}", user.getUser_id());
        try {
            // [인증]
            Authentication authenticate = authenticationManager.authenticate(
                    // 1.   AuthenticationProvider 호출 : 인증 작업을 수행
                    // 1-1. DaoAuthenticationProvider 를 사용
                    // 1-2. UserDetailsService 호출 : UserDetails 객체 반환(사용자ID, 암호화된 PW, ROLE)
                    // 1-3. DaoAuthenticationProvider 에서 비밀번호를 검증( UserDetails PW랑, 입력된 PW 비교 )
                    // 2.   인증성공 Authentication 반환
                    new UsernamePasswordAuthenticationToken(user.getUser_id(), user.getUser_pw())
            );
            // 인증된 사용자 정보 확인
            user = (LoginVO) authenticate.getPrincipal();
            LOGGER.info("[LoginServiceImpl] : {}", user.getAuthorities());

            // [발급] access token, refresh token
            String accessToken = jwtService.generateAccessToken(user);
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
                throw new RuntimeException("서버 오류로 인해 토큰 저장에 실패했습니다");
            }
            return new AuthResponse(accessToken, refreshToken);

        } catch (UsernameNotFoundException e) {
            LOGGER.error("[authenticationManager.authenticate] 사용자를 찾을 수 없습니다.");
            throw new CustomException("사용자를 찾을 수 없습니다");
        } catch (BadCredentialsException e) {
            LOGGER.error("[authenticationManager.authenticate] 비밀번호가 일치하지 않습니다");
            throw new CustomException("비밀번호가 일치하지 않습니다");
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

    @Override
    public void changeUsrPassword(Map<String, String> params) {

        // PASSWORD 암호화
        String encodedPassword = passwordEncoder.encode(params.get("user_pw"));

        params.put("user_pw", encodedPassword);
        commonDAO.changeUsrPassword(params);
    }

    @Override
    public void deleteUsr(String user_id) {
        commonDAO.deleteUsr(user_id);
    }
}
