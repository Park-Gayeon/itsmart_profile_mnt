package kr.co.itsmart.profileMnt.service;

import jakarta.servlet.http.HttpServletResponse;
import kr.co.itsmart.profileMnt.vo.ProfileVO;

import java.io.IOException;

public interface ExcelDownService {
    void downloadUsrProfileDetailExcel(ProfileVO profile, HttpServletResponse response) throws IOException;
}
