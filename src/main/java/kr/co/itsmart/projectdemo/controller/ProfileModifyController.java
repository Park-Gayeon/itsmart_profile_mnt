package kr.co.itsmart.projectdemo.controller;

import kr.co.itsmart.projectdemo.service.CommonService;
import kr.co.itsmart.projectdemo.service.ProfileDetailService;
import kr.co.itsmart.projectdemo.service.ProfileModifyService;
import kr.co.itsmart.projectdemo.vo.CommonVO;
import kr.co.itsmart.projectdemo.vo.ProfileVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/profile/modify")
public class ProfileModifyController {
    private final ProfileModifyService profileModifyService;
    private final CommonService commonService;

    public ProfileModifyController(ProfileModifyService profileModifyService, CommonService commonService) {
        this.profileModifyService = profileModifyService;
        this.commonService = commonService;
    }


    @PostMapping("/{user_id}")
    public String modifyUsrProfile(
            @PathVariable("user_id") String user_id,
            @ModelAttribute ProfileVO profile,
            Model model)
    {

        System.out.println(profile.getHire_date());
        System.out.println(profile.getWorkExperienceList());
        System.out.println(profile.getProjectList());
        System.out.println(profile.getQualificationList());


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

}
