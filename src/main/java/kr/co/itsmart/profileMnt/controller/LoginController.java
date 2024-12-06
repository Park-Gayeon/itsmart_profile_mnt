package kr.co.itsmart.profileMnt.controller;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.itsmart.profileMnt.service.LoginService;
import kr.co.itsmart.profileMnt.vo.LoginVO;
import kr.co.itsmart.profileMnt.vo.auth.AuthRequest;
import kr.co.itsmart.profileMnt.vo.auth.AuthResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
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
    public String loginView(HttpServletResponse response) {
        // 로그인 페이지를 호출하면 기존에 Cookie 에 저장된 Access Token 을 무효화 시킨다.
        Cookie deleteAccessCookie = new Cookie("accessToken", null);
        deleteAccessCookie.setHttpOnly(true);
        deleteAccessCookie.setPath("/");
        deleteAccessCookie.setMaxAge(0); // cookie 만료

        response.addCookie(deleteAccessCookie);
        return "login";
    }

    @PostMapping("/login")
    public ResponseEntity<Object> authenticate(@RequestBody AuthRequest login, HttpServletResponse response) {
        LoginVO user = new LoginVO();
        user.setUser_id(login.user_id());
        user.setUser_pw(login.user_pw());

        // [인증 및 Token 발급]
        AuthResponse tokenInfo = loginService.authenticate(user);

        // [cookie - access token]
        Cookie accessTokenCookie = new Cookie("accessToken", tokenInfo.accessToken());
        accessTokenCookie.setHttpOnly(true);       // HttpOnly 설정 (스크립트 접근 불가)
        accessTokenCookie.setPath("/");            // 전체경로에서 유효
        accessTokenCookie.setMaxAge(60 * 10);      // 10 min

        response.addCookie(accessTokenCookie);

        return ResponseEntity.ok().build();
    }

    @PostMapping("/logout")
    public ResponseEntity<Void> logout(){
        return ResponseEntity.ok().build();
    }
}
