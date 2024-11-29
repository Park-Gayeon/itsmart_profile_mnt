package kr.co.itsmart.profileMnt.controller;

import kr.co.itsmart.profileMnt.service.QualificationMntService;
import kr.co.itsmart.profileMnt.vo.ProfileVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/profile/qualification")
public class QualificationMntController {
    private static final Logger LOGGER = LoggerFactory.getLogger(QualificationMntController.class);
    private final QualificationMntService qualificationMntService;

    public QualificationMntController(QualificationMntService qualificationMntService) {
        this.qualificationMntService = qualificationMntService;
    }

    @PostMapping("/save/{user_id}")
    @ResponseBody
    public String updateQualificationInfo(@PathVariable("user_id")String user_id, @ModelAttribute ProfileVO profile){
        LOGGER.info("== Ajax[사용자 프로필 수정 처리(자격증)] ==");
        try {
            // CREATE hist_seq
            int hist_seq = qualificationMntService.selectMaxHistSeq(user_id);
            profile.setHist_seq(hist_seq);
            LOGGER.info("자격증 정보 hist_seq: hist_seq={}", hist_seq);

            // 자격증 정보 수정 처리
            qualificationMntService.updateUsrQualification(profile);
        } catch (Exception e){
            LOGGER.debug("자격증 정보 처리 실패: user_id={}", user_id, e.getMessage());
            return "FAIL";
        }
        return "SUCCESS";
    }
}
