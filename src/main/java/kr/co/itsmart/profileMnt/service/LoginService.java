package kr.co.itsmart.profileMnt.service;

import kr.co.itsmart.profileMnt.vo.LoginVO;
import kr.co.itsmart.profileMnt.vo.auth.AuthResponse;

public interface LoginService {
    AuthResponse authenticate(LoginVO loginVO);


}
