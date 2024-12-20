package kr.co.itsmart.profileMnt.controller;

import kr.co.itsmart.profileMnt.service.*;
import kr.co.itsmart.profileMnt.vo.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Lazy;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/profile")
public class ProfileMntController {
    private final Logger LOGGER = LoggerFactory.getLogger(this.getClass());
    private final CommonService commonService;
    private final ProfileMntService profileMntService;
    private final ProjectMntService projectMntService;
    private final WorkExperienceMntService workExperienceMntService;

    public ProfileMntController(ProfileMntService profileMntService,
                                CommonService commonService,
                                @Lazy ProjectMntService projectMntService,
                                @Lazy WorkExperienceMntService workExperienceMntService
    ) {
        this.profileMntService = profileMntService;
        this.commonService = commonService;
        this.projectMntService = projectMntService;
        this.workExperienceMntService = workExperienceMntService;
    }

    @GetMapping("/{user_id}")
    public String selectDetailInfo(@AuthenticationPrincipal LoginVO login,
                                   @PathVariable("user_id") String user_id,
                                   Model model) {
        LOGGER.info("== go selectProfileDetail[사용자 프로필 상세 화면] ==");
        ProfileVO profile = profileMntService.selectUsrProfileDetail(user_id);

        Map<String, String> params = new HashMap<>();
        params.put("code_group_id", "TASK");
        params.put("task_type", "lar");
        List<CommonVO> taskLarList = commonService.selectCodeList(params);

        params.clear();
        params.put("code_group_id", "TASK");
        List<CommonVO> taskMidList = commonService.selectCodeList(params);
        params.put("code_group_id", "PSIT");
        List<CommonVO> psitList = commonService.selectCodeList(params);
        params.put("code_group_id", "ROLE");
        List<CommonVO> roleList = commonService.selectCodeList(params);

        String code_group_id = "ORG";
        List<CommonVO> orgList = commonService.selectPureCodeList(code_group_id);
        int pj_totalMonth = projectMntService.calcTotalMonth(user_id);
        int wk_totalMonth = workExperienceMntService.calcTotalMonth(user_id);

        model.addAttribute("loginUser", login.getUser_id());
        model.addAttribute("userRole", login.getAuthorities());
        model.addAttribute("profile", profile);
        model.addAttribute("taskLarList", taskLarList);
        model.addAttribute("taskMidList", taskMidList);
        model.addAttribute("orgList", orgList);
        model.addAttribute("psitList", psitList);
        model.addAttribute("roleList", roleList);
        model.addAttribute("pj_totalMonth", pj_totalMonth);
        model.addAttribute("wk_totalMonth", wk_totalMonth);
        return "selectProfileDetail";
    }

    @PostMapping("/save/{user_id}")

    public ResponseEntity<String> updateUsrProfile(@PathVariable("user_id") String user_id,
                                           @ModelAttribute ProfileVO profile,
                                           @RequestParam(required = false, value = "imgFile") MultipartFile file) {
        LOGGER.info("== Ajax[사용자 프로필 수정 처리(인적사항)] ==");
        try {
            if(file != null){
                // CREATE file_seq
                int file_seq = commonService.selectMaxHistSeq(user_id);
                LOGGER.info("파일 정보 file_seq: file_seq={}", file_seq);

                // 파일 서버 저장
                FileVO fileVO = commonService.saveImageFile(file);

                // 파일 정보 DB 저장
                fileVO.setUser_id(user_id);
                fileVO.setFile_seq(file_seq);
                commonService.insertUsrFileInfo(fileVO);
            }

            // CREATE hist_seq
            int hist_seq = profileMntService.selectMaxHistSeq(user_id);
            profile.setHist_seq(hist_seq);
            LOGGER.info("프로필 정보 hist_seq: hist_seq={}", hist_seq);

            // 프로필 수정 처리
            profileMntService.updateUsrProfileInfo(profile);

            return ResponseEntity.ok("SUCCESS");

        } catch (Exception e) {
            LOGGER.debug("프로필 정보 처리 실패: user_id={}", user_id, e.getMessage());
            return ResponseEntity.internalServerError().body("프로필 정보 처리에 실패했습니다." + e.getMessage());
        }
    }
}

