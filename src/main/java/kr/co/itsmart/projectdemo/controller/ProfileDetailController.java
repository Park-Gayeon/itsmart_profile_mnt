package kr.co.itsmart.projectdemo.controller;

import kr.co.itsmart.projectdemo.service.ProfileDetailService;
import kr.co.itsmart.projectdemo.vo.ProfileVO;
import kr.co.itsmart.projectdemo.vo.ProjectVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
@RequestMapping("/profile/detail")
public class ProfileDetailController {
    private final ProfileDetailService profileDetailService;

    public ProfileDetailController(ProfileDetailService profileDetailService) {
        this.profileDetailService = profileDetailService;
    }

    @GetMapping("/{user_id}")
    public String selectDetailInfo(@PathVariable("user_id") String user_id, Model model){
        ProfileVO profile = profileDetailService.selectUsrProfileDetail(user_id);

        model.addAttribute("profile", profile);
        return "selectProfileDetail";
    }

    @GetMapping("/skill/select")
    public String selectUsrSkill(
            @RequestParam("user_id") String user_id,
            @RequestParam("project_seq") int project_seq,
            Model model){
        ProjectVO tmpVO = new ProjectVO();
        tmpVO.setUser_id(user_id);
        tmpVO.setProject_seq(project_seq);
        ProjectVO skill = profileDetailService.selectUsrSkillList(tmpVO);
        System.out.println(skill.getSkillList());

        model.addAttribute("skill", skill);
        return "viewSkill";
    }

    // TODO : 엑셀다운로드 준비중
    @GetMapping("/excel/{user_id}/download")
    public String exceldown(@PathVariable("user_id") String user_id, Model model){
        return "";
    }


}
