package kr.co.itsmart.profileMnt.controller;

import kr.co.itsmart.profileMnt.service.ProfileDetailService;
import kr.co.itsmart.profileMnt.service.ProjectMntService;
import kr.co.itsmart.profileMnt.service.WorkExperienceMntService;
import kr.co.itsmart.profileMnt.vo.ProfileVO;
import kr.co.itsmart.profileMnt.vo.ProjectVO;
import org.springframework.context.annotation.Lazy;
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
    private final ProjectMntService projectMntService;
    private final WorkExperienceMntService workExperienceMntService;
    /* @Lazy : Bean이 실제로 사용될 때만 초기화 => 불필요한 리소스 소비 줄임 */
    public ProfileDetailController(ProfileDetailService profileDetailService,
                                   @Lazy ProjectMntService projectMntService,
                                   @Lazy WorkExperienceMntService workExperienceMntService) {
        this.profileDetailService = profileDetailService;
        this.projectMntService = projectMntService;
        this.workExperienceMntService = workExperienceMntService;
    }

    @GetMapping("/{user_id}")
    public String selectDetailInfo(@PathVariable("user_id") String user_id, Model model){
        ProfileVO profile = profileDetailService.selectUsrProfileDetail(user_id);

        int pj_totalMonth = projectMntService.calcTotalMonth(user_id);
        int wk_totalMonth = workExperienceMntService.calcTotalMonth(user_id);

        model.addAttribute("profile", profile);
        model.addAttribute("pj_totalMonth", pj_totalMonth);
        model.addAttribute("wk_totalMonth", wk_totalMonth);
        return "selectProfileDetail";
    }

    @GetMapping("/skill/select")
    public String selectUsrSkill(
            @RequestParam("user_id") String user_id,
            @RequestParam("project_seq") int project_seq,
            @RequestParam(value = "flag", defaultValue = "0") int flag,
            Model model){
        ProjectVO tmpVO = new ProjectVO();
        tmpVO.setUser_id(user_id);
        tmpVO.setProject_seq(project_seq);
        ProjectVO skill = profileDetailService.selectUsrSkillList(tmpVO);

        // flag : 1 => selectProfileModify.jsp
        model.addAttribute("flag", flag);
        model.addAttribute("project", tmpVO);
        model.addAttribute("skill", skill);
        return "viewSkill";
    }

    // TODO : 엑셀다운로드 준비중
    @GetMapping("/excel/{user_id}/download")
    public String exceldown(@PathVariable("user_id") String user_id, Model model){
        return "";
    }


}
