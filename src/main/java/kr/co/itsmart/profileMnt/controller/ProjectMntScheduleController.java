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
import org.springframework.web.bind.annotation.*;

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

        int userCnt = scheduleService.getListCnt(profile);

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
        List<ProfileVO> usrProjectList = scheduleService.getProjectList(profile);

        model.addAttribute("loginUser", login.getUser_id());
        model.addAttribute("userRole", login.getAuthorities());
        model.addAttribute("list", usrProjectList);
        model.addAttribute("cnt", userCnt);
        model.addAttribute("page", pageVO);


        return "usersProjectSchedule";
    }

    @GetMapping("/info/{project_nm}")
    public String openUsersInfoPop(ProfileVO profile, Model model){
        logger.info("== open openUsersInfoPop[투입인력 정보 팝업] ==");

        if (!"".equals(profile.getProject_start_date()) && profile.getProject_start_date() != null) {
            profile.setProject_start_date(profile.getProject_start_date().replace("-", ""));
        }
        if(!"".equals(profile.getProject_end_date()) && profile.getProject_end_date() != null) {
            profile.setProject_end_date(profile.getProject_end_date().replace("-", ""));
        }

        logger.info("project_nm : {}", profile.getProject_nm() );
        logger.info("project_start_date : {}", profile.getProject_start_date());
        logger.info("project_end_date : {}" , profile.getProject_end_date());

        List<ProfileVO> usrInfo = scheduleService.getUsersInfoList(profile);

        model.addAttribute("info", usrInfo);
        return "selectUsersInfo";
    }

}
