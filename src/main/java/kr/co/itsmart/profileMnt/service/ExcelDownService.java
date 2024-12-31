package kr.co.itsmart.profileMnt.service;

import jakarta.servlet.http.HttpServletResponse;
import kr.co.itsmart.profileMnt.vo.ProfileVO;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

public interface ExcelDownService {
    void downloadUsrProfileDetailExcel(ProfileVO profile, HttpServletResponse response) throws IOException;

    void downloadUsrProfileAllListExcel(List<ProfileVO> list, HttpServletResponse response) throws IOException;

    void uploadKosaExcel(MultipartFile excel, String useer_id) throws IOException;
}
