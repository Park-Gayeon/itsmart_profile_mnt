package kr.co.itsmart.profileMnt.controller;

import kr.co.itsmart.profileMnt.service.CommonService;
import kr.co.itsmart.profileMnt.service.ProjectMntService;
import kr.co.itsmart.profileMnt.vo.CommonVO;
import kr.co.itsmart.profileMnt.vo.ProfileVO;
import kr.co.itsmart.profileMnt.vo.ProjectVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/profile/project")
public class ProjectMntController {
    private final Logger LOGGER = LoggerFactory.getLogger(this.getClass());
    private final ProjectMntService projectMntService;
    private final CommonService commonService;

    public ProjectMntController(ProjectMntService projectMntService,
                                @Lazy CommonService commonService) {
        this.projectMntService = projectMntService;
        this.commonService = commonService;
    }

    @GetMapping("/add")
    public String addProject(@RequestParam("user_id") String user_id, Model model) {
        LOGGER.info("== open addNewProject[프로젝트 추가 팝업] ==");
        int maxSeq = projectMntService.getProjectMaxSeq(user_id);

        Map<String, String> params = new HashMap<>();
        params.put("code_group_id", "TASK");
        params.put("task_type", "lar");
        List<CommonVO> taskLarList = commonService.getCodeList(params);

        params.clear();
        params.put("code_group_id", "TASK");
        List<CommonVO> taskMidList = commonService.getCodeList(params);
        model.addAttribute("taskLarList", taskLarList);
        model.addAttribute("taskMidList", taskMidList);
        model.addAttribute("maxSeq", maxSeq);
        return "addNewProject";
    }

    @PostMapping("/save/{user_id}")
    @ResponseBody
    public String updateProjectInfo(@PathVariable("user_id") String user_id, @ModelAttribute ProfileVO profile) {
        LOGGER.info("== Ajax[사용자 프로필 수정 처리(사업경력)] ==");
        try {
            // CREATE hist_seq
            int hist_seq = projectMntService.getMaxHistSeq(user_id);
            profile.setHist_seq(hist_seq);
            LOGGER.info("사업 정보 hist_seq: hist_seq={}", hist_seq);

            // 사업 정보 수정 처리
            projectMntService.updateUsrProject(profile);
        } catch (Exception e) {
            LOGGER.debug("사업 정보 처리 실패: user_id={}", user_id, e.getMessage());
            return "FAIL";
        }
        return "SUCCESS";
    }

    @GetMapping("/select/task")
    @ResponseBody
    public List<CommonVO> getTaskMidCode(@RequestParam("code_id") String code_id) {
        LOGGER.info("== Ajax[업무분류 조회 code_id={}] ==", code_id);

        List<CommonVO> results = commonService.getTaskMidCodeList(code_id);
        return results;
    }

    @GetMapping("/select/skill")
    public String getUsrSkill(
            @RequestParam("user_id") String user_id,
            @RequestParam("project_seq") int project_seq,
            @RequestParam(value = "flag", defaultValue = "0") int flag,
            Model model) {
        LOGGER.info("== open viewSkill[사용자 프로젝트별 기술 정보 팝업] ==");

        ProjectVO project = new ProjectVO();
        project.setUser_id(user_id);
        project.setProject_seq(project_seq);
        ProjectVO skill = projectMntService.getUsrSkillList(project);

        // flag : 1 => edit
        model.addAttribute("flag", flag);
        model.addAttribute("project", project);
        model.addAttribute("skill", skill);
        return "viewSkill";
    }

    @PostMapping("/save/skill")
    @ResponseBody
    public String updateUsrSkill(@ModelAttribute ProjectVO project) {
        LOGGER.info("== Ajax[사용자 프로필 수정 처리(기술)] ==");
        try {
            // CREATE hist_seq
            int hist_seq = projectMntService.getMaxSkillSeq(project);
            LOGGER.info("기술 정보 hist_seq: hist_seq={}", hist_seq);
            project.setHist_seq(hist_seq);

            // 기술 정보 수정 처리
            projectMntService.updateUsrSkill(project);

        } catch (Exception e) {
            LOGGER.debug("기술 정보 처리 실패: user_id={}, project_seq={}", project.getUser_id(), project.getProject_seq(), e.getMessage());
            return "FAIL";
        }
        return "SUCCESS";
    }
}
