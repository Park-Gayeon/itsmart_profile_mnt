package kr.co.itsmart.profileMnt.service;

import kr.co.itsmart.profileMnt.configuration.security.provider.JwtService;
import kr.co.itsmart.profileMnt.vo.LoginVO;
import kr.co.itsmart.profileMnt.vo.auth.AuthResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class LoginServiceImpl implements LoginService{
    private static final Logger LOGGER = LoggerFactory.getLogger(ProfileInfoServiceImpl.class);
    private final AuthenticationManager authenticationManager;
    private final JwtService jwtService;

    public LoginServiceImpl(AuthenticationManager authenticationManager, JwtService jwtService) {
        this.authenticationManager = authenticationManager;
        this.jwtService = jwtService;
    }

    @Override
    public AuthResponse authenticate(LoginVO user) {
        LOGGER.info("[LoginServiceImpl - authenticate 진입] - LoginVO] id : {}", user.getUser_id());
        LOGGER.info("[LoginServiceImpl - authenticate 진입] - LoginVO] pw : {}", user.getUser_pw());
        try {
            authenticationManager.authenticate(
                    // 1. AuthenticationProvider 호출 : 인증 작업을 수행
                    // 1-1. DaoAuthenticationProvider 를 사용
                    // 1-2. UserDetailsService 호출 : UserDetails 객체 반환(사용자ID, 암호화된 PW)
                    // 2. DaoAuthenticationProvider 에서 비밀번호를 검증( UserDetails PW랑, 입력된 PW 비교 )
                    // 3. 인증성공 Authentication 반환
                    new UsernamePasswordAuthenticationToken(user.getUser_id(), user.getUser_pw())
            );
            String token = jwtService.generateToken(user);
            return new AuthResponse(token);

        } catch (BadCredentialsException e) {
            LOGGER.error("비밀번호 불일치");
            throw e;
        } catch (UsernameNotFoundException e) {
            LOGGER.error("사용자를 찾을 수 없습니다.");
            throw e;
        }
    }
}
