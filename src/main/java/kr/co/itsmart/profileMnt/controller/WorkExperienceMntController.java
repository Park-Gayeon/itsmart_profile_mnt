package kr.co.itsmart.profileMnt.controller;

import kr.co.itsmart.profileMnt.service.WorkExperienceMntService;
import kr.co.itsmart.profileMnt.vo.ProfileVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/profile/workExperience/modify")
public class WorkExperienceMntController {
    private static final Logger LOGGER = LoggerFactory.getLogger(QualificationMntController.class);
    private final WorkExperienceMntService workExperienceMntService;

    public WorkExperienceMntController(WorkExperienceMntService workExperienceMntService){
        this.workExperienceMntService = workExperienceMntService;
    }

    @PostMapping("/save/{user_id}")
    @ResponseBody
    public String updateWorkExperienceInfo(@PathVariable("user_id")String user_id, @ModelAttribute ProfileVO profile){
        LOGGER.info("== Ajax[사용자 프로필 수정 처리(근무경력)] ==");
        try {
            // CREATE hist_seq
            int hist_seq = workExperienceMntService.selectMaxHistSeq(user_id);
            profile.setHist_seq(hist_seq);
            LOGGER.info("근무 정보 hist_seq: hist_seq={}", hist_seq);

            // 근무 정보 수정 처리
            workExperienceMntService.updateUsrWorkExperience(profile);
        } catch (Exception e){
            LOGGER.debug("근무 정보 처리 실패: user_id={}", user_id, e.getMessage());
            return "FAIL";
        }
        return "SUCCESS";
    }
}
