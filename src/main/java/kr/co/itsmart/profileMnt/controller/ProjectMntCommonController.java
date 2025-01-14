package kr.co.itsmart.profileMnt.controller;

import kr.co.itsmart.profileMnt.service.ProjectCommonService;
import kr.co.itsmart.profileMnt.service.ProjectMntService;
import kr.co.itsmart.profileMnt.vo.LoginVO;
import kr.co.itsmart.profileMnt.vo.PageVO;
import kr.co.itsmart.profileMnt.vo.ProjectVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;

@Controller
@RequestMapping("/project/common")
public class ProjectMntCommonController {
    private final Logger logger = LoggerFactory.getLogger(this.getClass());
    private final ProjectCommonService projectCommonService;
    private final ProjectMntService projectMntService;

    public ProjectMntCommonController(ProjectCommonService projectCommonService,
                                      ProjectMntService projectMntService) {
        this.projectCommonService = projectCommonService;
        this.projectMntService = projectMntService;
    }

    @GetMapping("/list")
    public String getProjectList(@AuthenticationPrincipal LoginVO login,
                                 @ModelAttribute ProjectVO project,
                                 Model model) {
        logger.info("== go getProjectList[프로젝트 관리 화면] ==");

        logger.info("검색조건 확인 searchType={}, searchText={}", project.getSearchType(), project.getSearchText());

        int defaultCurPage = 1;
        if (project.getCurPage() == 0) {
            project.setCurPage(defaultCurPage);
        }

        int curPage = project.getCurPage();
        logger.info("curPage : {}", curPage);

        int listCnt = projectCommonService.getListCnt(project);

        PageVO pageVO = new PageVO(listCnt, curPage);
        project.setOffset(pageVO.getStartIndex());
        project.setLimit(pageVO.getPageSize());

        List<ProjectVO> list = projectCommonService.getProjectList(project);

        model.addAttribute("loginUser", login.getUser_id());
        model.addAttribute("userRole", login.getAuthorities());
        model.addAttribute("cnt", listCnt);
        model.addAttribute("list", list);
        model.addAttribute("searchType", project.getSearchType());
        model.addAttribute("searchText", project.getSearchText());
        model.addAttribute("page", pageVO);
        return "selectProjectCommonInfo";
    }

    @GetMapping("/register")
    public String openRegisterProjectPop() {
        logger.info("== openRegisterProjectPop[신규 프로젝트 등록 팝업] ==");
        return "registerProject";
    }


    @PostMapping("/register")
    public ResponseEntity<Object> registerProjectInfo(@ModelAttribute ProjectVO project,
                                                      @AuthenticationPrincipal LoginVO login) {
        logger.info("== Ajax[신규 프로젝트 등록 처리] ==");

        String master_id = generateUniqueId();
        project.setMaster_id(master_id);
        project.setCreator(login.getUser_id());

        // db insert
        projectCommonService.insertProjectCommon(project);


        return ResponseEntity.ok().build();
    }

    @PostMapping("/update")
    public ResponseEntity<Object> updateProjectInfo(@RequestBody ProjectVO project, @AuthenticationPrincipal LoginVO login){
        logger.info("== Ajax[프로젝트 사용여부 변경 처리] ==");

        project.setModifier(login.getUser_id());
        projectCommonService.updateProjectCommon(project);

        return ResponseEntity.ok().build();
    }

    @GetMapping("/getList")
    public String openGetProjectListPop(@RequestParam("user_id") String user_id,
                                        @ModelAttribute ProjectVO project, Model model){
        logger.info("== openGetProjectListPop[프로젝트 목록 조회 팝업] ==");

        logger.info("검색조건 확인 searchType={}, searchText={}", project.getSearchType(), project.getSearchText());

        int defaultCurPage = 1;
        if (project.getCurPage() == 0) {
            project.setCurPage(defaultCurPage);
        }

        int curPage = project.getCurPage();
        logger.info("curPage : {}", curPage);

        int maxSeq = projectMntService.getProjectMaxSeq(user_id);
        int listCnt = projectCommonService.getProjectCntPop(project);

        PageVO pageVO = new PageVO(listCnt, curPage);
        project.setOffset(pageVO.getStartIndex());
        project.setLimit(pageVO.getPageSize());

        List<ProjectVO> list = projectCommonService.getProjectListPop(project);

        model.addAttribute("cnt", listCnt);
        model.addAttribute("list", list);
        model.addAttribute("searchType", project.getSearchType());
        model.addAttribute("searchText", project.getSearchText());
        model.addAttribute("page", pageVO);
        model.addAttribute("userId", user_id);
        model.addAttribute("maxSeq", maxSeq);

        return "selectProjectList";
    }


    // MASTER_ID 생성(시간 기반 (Timestamp + Random Number))
    public static String generateUniqueId() {

        // 1. 현재 날짜 및 시간에서 고유한 부분 추출 (예: 초 단위)
        SimpleDateFormat sdf = new SimpleDateFormat("ssSSS"); // "ssSSS": 초와 밀리초
        String timePart = sdf.format(new Date());

        // 2. 랜덤 숫자 생성
        Random random = new Random();
        int randomPart = random.nextInt(10); // 0부터 10까지의 랜덤 숫자

        // 3. 고유 ID 생성 (앞부분은 시간, 뒷부분은 랜덤 숫자)
        // 자리수를 맞추기 위해 포맷팅 사용
        return String.format("%s%02d", timePart, randomPart).substring(0, 6);
    }
}



