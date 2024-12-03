package kr.co.itsmart.profileMnt.controller;

import kr.co.itsmart.profileMnt.service.LoginService;
import kr.co.itsmart.profileMnt.vo.LoginVO;
import kr.co.itsmart.profileMnt.vo.auth.AuthRequest;
import kr.co.itsmart.profileMnt.vo.auth.AuthResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/auth")
public class LoginController {
    private final Logger logger = LoggerFactory.getLogger(this.getClass());
    private final LoginService loginService;

    public LoginController(LoginService loginService) {
        this.loginService = loginService;
    }

    @GetMapping("/login/main")
    public String loginView() {
        return "login";
    }

    @PostMapping("/login")
    public ResponseEntity<AuthResponse> authenticate(@RequestBody AuthRequest login) {
        LoginVO user = LoginVO.builder()
                .user_id(login.user_id())
                .user_pw(login.user_pw())
                .build();
        try {
            AuthResponse response = loginService.authenticate(user);
            return ResponseEntity.ok(response);
        } catch (BadCredentialsException e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(new AuthResponse("비밀번호가 올바르지 않습니다."));
        } catch (UsernameNotFoundException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(new AuthResponse("사용자를 찾을 수 없습니다."));
        }
    }
}


