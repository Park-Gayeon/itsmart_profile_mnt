package kr.co.itsmart.profileMnt.controller;

import jakarta.servlet.http.HttpServletResponse;
import kr.co.itsmart.profileMnt.service.ExcelDownService;
import kr.co.itsmart.profileMnt.service.ProfileMntService;
import kr.co.itsmart.profileMnt.vo.ProfileVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.io.IOException;

@Controller
@RequestMapping("/excel")
public class ExcelDownController {
    private final Logger logger = LoggerFactory.getLogger(this.getClass());
    private final ExcelDownService excelDownService;
    private final ProfileMntService profileMntService;

    public ExcelDownController(ExcelDownService excelDownService, ProfileMntService profileMntService) {
        this.excelDownService = excelDownService;
        this.profileMntService = profileMntService;
    }

    @PostMapping("/{user_id}/download")
    public void excelDown(@PathVariable("user_id") String user_id,
                          HttpServletResponse response) throws IOException {
        logger.info("== Ajax[사용자 프로필 EXCEL DOWNLOAD] ==");

        ProfileVO profile = profileMntService.selectUsrProfileDetail(user_id);
        excelDownService.downloadUsrProfileDetailExcel(profile, response);
    }
}
