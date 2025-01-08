package kr.co.itsmart.profileMnt.controller;

import kr.co.itsmart.profileMnt.service.ScheduleService;
import kr.co.itsmart.profileMnt.vo.LoginVO;
import kr.co.itsmart.profileMnt.vo.PageVO;
import kr.co.itsmart.profileMnt.vo.ProfileVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/schedule")
public class ProjectMntScheduleController {
    private final Logger logger = LoggerFactory.getLogger(this.getClass());
    private final ScheduleService scheduleService;

    public ProjectMntScheduleController(ScheduleService scheduleService) {
        this.scheduleService = scheduleService;
    }

    @GetMapping("/list")
    public String selectProjectScheduleList(@AuthenticationPrincipal LoginVO login,
                                            @ModelAttribute ProfileVO profile,
                                            Model model){
        logger.info("== go selectProjectScheduleList[직원 프로젝트 일정관리 화면] ==");

        model.addAttribute("project_start_date", profile.getProject_start_date());
        model.addAttribute("project_end_date", profile.getProject_end_date());

        if (!"".equals(profile.getProject_start_date()) && profile.getProject_start_date() != null) {
            profile.setProject_start_date(profile.getProject_start_date().replace("-", ""));
        }
        if(!"".equals(profile.getProject_end_date()) && profile.getProject_end_date() != null) {
            profile.setProject_end_date(profile.getProject_end_date().replace("-", ""));
        }

        logger.info("project_start_date: {}", profile.getProject_start_date());
        logger.info("project_end_date: {}", profile.getProject_end_date());

        int userCnt = scheduleService.getUsrListCnt(profile);

        int defaultCurPage = 1;
        if(profile.getCurPage() == 0){
            profile.setCurPage(defaultCurPage);
        }

        int curPage = profile.getCurPage();
        logger.info("curPage : {}", curPage);

        PageVO pageVO = new PageVO(userCnt, curPage);
        profile.setOffset(pageVO.getStartIndex());
        profile.setLimit(pageVO.getPageSize());

        // list 조회
        List<ProfileVO> usrProjectList = scheduleService.getUsrProjectList(profile);

        model.addAttribute("loginUser", login.getUser_id());
        model.addAttribute("userRole", login.getAuthorities());
        model.addAttribute("list", usrProjectList);
        model.addAttribute("cnt", userCnt);
        model.addAttribute("page", pageVO);


        return "usersProjectSchedule";
    }

    @GetMapping("/info/{user_id}")
    public String openUsrInfoPop(@PathVariable("user_id") String user_id, Model model){
        logger.info("== open openUsrInfoPop[사용자 정보 팝업] ==");

        ProfileVO usrInfo = scheduleService.getUsrInfo(user_id);

        model.addAttribute("info", usrInfo);
        return "selectUsrInfo";
    }

}
