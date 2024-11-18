package kr.co.itsmart.projectdemo.controller;

import kr.co.itsmart.projectdemo.service.CommonService;
import kr.co.itsmart.projectdemo.service.ProfileMntService;
import kr.co.itsmart.projectdemo.vo.CommonVO;
import kr.co.itsmart.projectdemo.vo.ProfileVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/profile/modify")
public class ProfileMntController {
private static final Logger LOGGER = LoggerFactory.getLogger(ProjectMntController.class);
    private final ProfileMntService profileMntService;
    private final CommonService commonService;

    public ProfileMntController(ProfileMntService profileMntService, CommonService commonService) {
        this.profileMntService = profileMntService;
        this.commonService = commonService;
    }


    @PostMapping("/info/{user_id}")
    public String modifyUsrProfile(@ModelAttribute ProfileVO profile, Model model) {
        List<CommonVO> orgList = commonService.selectCodeList("ORG");
        List<CommonVO> psitList = commonService.selectCodeList("PSIT");
        List<CommonVO> roleList = commonService.selectCodeList("ROLE");
        List<CommonVO> taskLarList = commonService.selectCodeList("TASK");
        List<CommonVO> taskMidLIst = commonService.selectCodeList("TASK");

        model.addAttribute("profile", profile);
        model.addAttribute("orgList", orgList);
        model.addAttribute("psitList", psitList);
        model.addAttribute("roleList", roleList);
        model.addAttribute("taskLarList", taskLarList);
        model.addAttribute("taskMidLIst", taskMidLIst);

        return "selectProfileModify";
    }

    @PostMapping("/{user_id}")
    @ResponseBody
    public String updateUsrProfile(@PathVariable("user_id") String user_id, @ModelAttribute ProfileVO profile) {
        try {
            // hist_seq
            int hist_seq = profileMntService.selectMaxSeq(user_id);
            profile.setHist_seq(hist_seq);
            LOGGER.info("프로필 정보 hist_seq: hist_seq={}", hist_seq);

            // 프로필 정보 처리
            profileMntService.updateUsrProfileInfo(profile);
        }catch (Exception e){
            LOGGER.debug("프로필 정보 처리 실패: user_id={}", user_id, e.getMessage());
            return "FAIL";
        }
        return "SUCCESS";
    }
}

