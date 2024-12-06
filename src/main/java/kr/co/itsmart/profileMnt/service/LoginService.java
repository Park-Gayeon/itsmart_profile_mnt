package kr.co.itsmart.profileMnt.service;

import jakarta.servlet.http.HttpServletRequest;
import kr.co.itsmart.profileMnt.vo.LoginVO;
import kr.co.itsmart.profileMnt.vo.auth.AuthResponse;

public interface LoginService {
    AuthResponse authenticate(LoginVO login);

    String getAccessTokenCookies(HttpServletRequest request);

}
