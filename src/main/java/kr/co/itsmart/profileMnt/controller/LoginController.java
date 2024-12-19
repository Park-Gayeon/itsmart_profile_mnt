package kr.co.itsmart.profileMnt.controller;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.itsmart.profileMnt.service.LoginService;
import kr.co.itsmart.profileMnt.vo.LoginVO;
import kr.co.itsmart.profileMnt.vo.auth.AuthRequest;
import kr.co.itsmart.profileMnt.vo.auth.AuthResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/auth")
public class LoginController {
    private final Logger logger = LoggerFactory.getLogger(this.getClass());
    private final LoginService loginService;

    @Value("${user.default-password}")
    private String defaultPassword;

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

    @GetMapping("/change/password/{user_id}")
    public String changePassword(@PathVariable("user_id") String user_id,
                                 Model model){
        logger.info("== open changePassword[사용자 비밀번호 변경 팝업] ==");
        model.addAttribute("user_id", user_id);

        return "changePassword";
    }

    @PostMapping("/save/password")
    public ResponseEntity<Object> savePassword(@AuthenticationPrincipal LoginVO login,
                                               @RequestBody AuthRequest usrInfo,
                                               @RequestParam(required = false) String flag){
        logger.info("== Ajax[사용자 비밀번호 변경 처리] ==");

        Map<String, String> params = new HashMap<>();
        params.put("user_id", usrInfo.user_id());
        String key = "1".equals(flag) ? defaultPassword : usrInfo.user_pw();
        params.put("user_pw", key);
        params.put("modifier", login.getUser_id());

        loginService.changeUsrPassword(params);

        return ResponseEntity.ok().build();
    }

    @PostMapping("/delete/{user_id}")
    public ResponseEntity<Object> deleteUsr(@PathVariable("user_id") String user_id){
        logger.info("== Ajax[사용자 삭제 처리] ==");
        loginService.deleteUsr(user_id);

        return ResponseEntity.ok().build();
    }
}
