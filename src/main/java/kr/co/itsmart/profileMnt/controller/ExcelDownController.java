package kr.co.itsmart.profileMnt.controller;

import java.io.IOException;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.itsmart.profileMnt.service.ExcelDownService;
import kr.co.itsmart.profileMnt.service.ProfileInfoService;
import kr.co.itsmart.profileMnt.service.ProfileMntService;
import kr.co.itsmart.profileMnt.vo.ProfileVO;

@Controller
@RequestMapping("/excel")
public class ExcelDownController {
    private final Logger logger = LoggerFactory.getLogger(this.getClass());
    private final ExcelDownService excelDownService;
    private final ProfileMntService profileMntService;
    private final ProfileInfoService profileInfoService;

    public ExcelDownController(ExcelDownService excelDownService,
                               ProfileMntService profileMntService,
                               ProfileInfoService profileInfoService) {
        this.excelDownService = excelDownService;
        this.profileMntService = profileMntService;
        this.profileInfoService = profileInfoService;
    }

    @PostMapping("/{user_id}/download")
    public void excelDown(@PathVariable("user_id") String user_id,
                          HttpServletResponse response) throws IOException {
        logger.info("== Ajax[사용자 프로필 EXCEL DOWNLOAD] ==");

        ProfileVO profile = profileMntService.selectUsrProfileDetail(user_id);
        excelDownService.downloadUsrProfileDetailExcel(profile, response);
    }

    @PostMapping("/info/download")
    public void excelAllDown(HttpServletResponse response) throws IOException {
        logger.info("== Ajax[직원 전체 프로필 EXCEL DOWNLOAD] ==");
        List<ProfileVO> profileNotPagingList = profileInfoService.getUsrProfileNotPagingInfoList();
        excelDownService.downloadUsrProfileAllListExcel(profileNotPagingList, response);
    }

    @GetMapping("/{user_id}/upload")
    public String openExcelUploadPop(@PathVariable("user_id") String user_id, Model model){
        logger.info("== openExcelUploadPop[엑셀 업로드 팝업] ==");
        model.addAttribute("user_id", user_id);
        return "uploadExcel";
    }

    @PostMapping("/{user_id}/upload")
    public ResponseEntity<Object> excelUpload(@PathVariable("user_id") String user_id,
                                              @RequestParam(value = "excel") MultipartFile excel) throws IOException {
        logger.info("== excelUpload[KOSA EXCEL UPLOAD] ==");
        excelDownService.uploadKosaExcel(excel, user_id);

        return ResponseEntity.ok().build();
    }
    
    @PostMapping("/{user_id}/downloadTemplate")
    public void excelDown(@PathVariable("user_id") String user_id, HttpServletRequest request,
                          HttpServletResponse response) throws IOException {
        logger.info("== Ajax[사용자 프로필 EXCEL DOWNLOAD] ==");

        ProfileVO profile = profileMntService.selectUsrProfileDetail(user_id);
        excelDownService.downloadUsrProfileDetailExcelTemplate(profile, request, response);
    }
    
    @GetMapping("/downloadTemplate")
    public void downloadTemplate(HttpServletRequest request, HttpServletResponse response) {
        excelDownService.downloadExcelTemplate(request, response);
    }
}
