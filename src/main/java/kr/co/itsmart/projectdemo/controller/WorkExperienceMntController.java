package kr.co.itsmart.projectdemo.controller;

import kr.co.itsmart.projectdemo.service.WorkExperienceMntService;
import kr.co.itsmart.projectdemo.vo.ProfileVO;
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

    @PostMapping("/{user_id}")
    @ResponseBody
    public String updateWorkExperienceInfo(@PathVariable("user_id")String user_id, @ModelAttribute ProfileVO profile){
        for(int i = 0; i<profile.getWorkExperienceList().size(); i++){
            LOGGER.info("근무지 명 work_place={}", profile.getWorkExperienceList().get(i).getWork_place());
        }
        try {
            // hist_seq
            int hist_seq = workExperienceMntService.selectMaxSeq(user_id);
            profile.setHist_seq(hist_seq);
            LOGGER.info("사용자 근무정보 hist_seq: hist_seq={}", hist_seq);

            // 사용자 근무 정보 처리
            workExperienceMntService.updateUsrWorkExperience(profile);
        } catch (Exception e){
            LOGGER.debug("사용자 자격 정보 처리 실패: user_id={}", user_id, e.getMessage());
            return "FAIL";
        }
        return "SUCCESS";
    }
}
