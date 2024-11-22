package kr.co.itsmart.profileMnt.controller;

import kr.co.itsmart.profileMnt.service.ProfileDetailService;
import kr.co.itsmart.profileMnt.service.ProjectMntService;
import kr.co.itsmart.profileMnt.service.WorkExperienceMntService;
import kr.co.itsmart.profileMnt.vo.ProfileVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/profile/detail")
public class ProfileDetailController {
    private static final Logger LOGGER = LoggerFactory.getLogger((ProfileDetailController.class));
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
    public String selectDetailInfo(@PathVariable("user_id") String user_id, Model model) {
        LOGGER.info("== go selectProfileDetail[사용자 프로필 상세 화면] ==");
        ProfileVO profile = profileDetailService.selectUsrProfileDetail(user_id);

        int pj_totalMonth = projectMntService.calcTotalMonth(user_id);
        int wk_totalMonth = workExperienceMntService.calcTotalMonth(user_id);

        model.addAttribute("profile", profile);
        model.addAttribute("pj_totalMonth", pj_totalMonth);
        model.addAttribute("wk_totalMonth", wk_totalMonth);
        return "selectProfileDetail";
    }


    // TODO : 엑셀다운로드 준비중
    @GetMapping("/excel/{user_id}/download")
    public String exceldown(@PathVariable("user_id") String user_id, Model model) {
        return "";
    }


}
