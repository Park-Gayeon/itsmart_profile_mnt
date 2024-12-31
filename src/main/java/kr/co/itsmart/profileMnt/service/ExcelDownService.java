package kr.co.itsmart.profileMnt.service;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.itsmart.profileMnt.vo.FileVO;
import kr.co.itsmart.profileMnt.vo.ProfileVO;
import org.springframework.web.multipart.MultipartFile;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;

public interface ExcelDownService {
    void downloadUsrProfileDetailExcel(ProfileVO profile, HttpServletResponse response) throws IOException;

    void downloadUsrProfileAllListExcel(List<ProfileVO> list, HttpServletResponse response) throws IOException;

    void uploadKosaExcel(MultipartFile excel, String useer_id) throws IOException;

	void downloadExcelTemplate(Integer fileSeq, HttpServletRequest request, HttpServletResponse response);
	
	void excelTemplateUpload(MultipartFile excel) throws IOException;

	void downloadUsrProfileDetailExcelTemplate(ProfileVO profile, FileVO templateFile, HttpServletRequest request,
			HttpServletResponse response) throws IOException;
}
