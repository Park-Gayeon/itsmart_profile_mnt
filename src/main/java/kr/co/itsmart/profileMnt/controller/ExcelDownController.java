package kr.co.itsmart.profileMnt.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.itsmart.profileMnt.service.ExcelDownService;
import kr.co.itsmart.profileMnt.service.FileService;
import kr.co.itsmart.profileMnt.service.ProfileInfoService;
import kr.co.itsmart.profileMnt.service.ProfileMntService;
import kr.co.itsmart.profileMnt.vo.FileVO;
import kr.co.itsmart.profileMnt.vo.ProfileVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/excel")
public class ExcelDownController {
    private final Logger logger = LoggerFactory.getLogger(this.getClass());
    private final ExcelDownService excelDownService;
    private final ProfileMntService profileMntService;
    private final ProfileInfoService profileInfoService;
    private final FileService fileService;

    public ExcelDownController(ExcelDownService excelDownService,
                               ProfileMntService profileMntService,
                               ProfileInfoService profileInfoService,
                               FileService fileService) {
        this.excelDownService = excelDownService;
        this.profileMntService = profileMntService;
        this.profileInfoService = profileInfoService;
        this.fileService = fileService;
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
    
    
    /**
     * 엑셀업로드 팝업 (템플릿)
     * @param model - 화면 정보를 저장하는 변수
     *
     * @return 모델 정보와 뷰 정보를 반환
     */
    @GetMapping("/excelTemplateUpload")
    public String openExcelTemplateUploadPop(Model model){
        logger.info("== openExcelUploadPop[엑셀 템플릿 업로드 팝업] ==");
        
        FileVO fileVo = new FileVO();
        fileVo.setFile_se("EXCEL_TEMP");
        
        List<FileVO> attachFileList = fileService.selectFileList(fileVo);
        model.addAttribute("attachFileList", attachFileList);
        return "uploadExcelTemplate";
    }
    
    /**
     * 엑셀다운로드 (템플릿 형식으로 프로필정보 다운로드)
     * @param user_id - 프로필 유저
     *
     * @return 사용자 프로필 템플릿 형식으로 다운
     */
    @PostMapping("/{user_id}/downloadTemplate/{file_seq}")
    public void excelDown(@PathVariable("user_id") String user_id, @PathVariable("file_seq") int file_seq, HttpServletRequest request,
                          HttpServletResponse response) throws IOException {
        logger.info("== Ajax[사용자 프로필 EXCEL TEMPLATE DOWNLOAD] ==");
        
        FileVO fileVo = new FileVO();
        FileVO templateFile = null;
        
        ProfileVO profile = profileMntService.selectUsrProfileDetail(user_id);
        if (file_seq != 0) {
        	fileVo.setFile_seq(file_seq);
        	templateFile = fileService.selectFileInfo(fileVo);
        } else {
        }
        excelDownService.downloadUsrProfileDetailExcelTemplate(profile, templateFile, request, response);
    }
    
    /**
     * 엑셀다운로드 (템플릿 형식 파일자체)
     * @return 템플릿 형식파일
     * @throws FileNotFoundException 
     */
    @GetMapping("/downloadTemplate/{file_seq}")
    public void downloadTemplate(@PathVariable("file_seq") Integer file_seq, HttpServletRequest request, HttpServletResponse response) {
    	logger.info("== Ajax[템플릿 EXCEL DOWNLOAD] ==");
        excelDownService.downloadExcelTemplate(file_seq, request, response);
    }
    
    /**
     * 엑셀 업로드 (템플릿 형식 파일)
     * @return 
     */
    @PostMapping("/excelTemplateUpload")
    public ResponseEntity<Object> excelTemplateUpload(@RequestParam(value = "excel") MultipartFile excel) throws IOException {
        logger.info("== excelUpload[EXCEL TEMPLATE UPLOAD] ==");
        excelDownService.excelTemplateUpload(excel);

        return ResponseEntity.ok().build();
    }
}
