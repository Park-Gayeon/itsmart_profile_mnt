package kr.co.itsmart.profileMnt.controller;

import kr.co.itsmart.profileMnt.service.CommonService;
import kr.co.itsmart.profileMnt.service.ProjectMntService;
import kr.co.itsmart.profileMnt.vo.CommonVO;
import kr.co.itsmart.profileMnt.vo.ProfileVO;
import kr.co.itsmart.profileMnt.vo.ProjectVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/profile/project/modify")
public class ProjectMntController {
    private static final Logger LOGGER = LoggerFactory.getLogger(ProjectMntController.class);
    private final ProjectMntService projectMntService;
    private final CommonService commonService;

    public ProjectMntController(ProjectMntService projectMntService, CommonService commonService) {
        this.projectMntService = projectMntService;
        this.commonService = commonService;
    }

    @GetMapping("/add")
    public String addProject(@RequestParam("user_id") String user_id, Model model){

        int maxSeq = projectMntService.getProjectMaxSeq(user_id);
        model.addAttribute("maxSeq", maxSeq);
        return "addNewProject";
    }

    @PostMapping("/{user_id}")
    @ResponseBody
    public String updateProjectInfo(@PathVariable("user_id")String user_id, @ModelAttribute ProfileVO profile){
        try {
            // hist_seq
            int hist_seq = projectMntService.selectMaxSeq(user_id);
            profile.setHist_seq(hist_seq);
            LOGGER.info("사업 정보 hist_seq: hist_seq={}", hist_seq);

            // 사업 정보 처리
            projectMntService.updateUsrProject(profile);
        } catch (Exception e){
            LOGGER.debug("사업 정보 처리 실패: user_id={}", user_id, e.getMessage());
            return "FAIL";
        }
        return "SUCCESS";
    }

    @GetMapping("/select/task")
    @ResponseBody
    public List<CommonVO> getTaskMidCode(@RequestParam("code_id")String code_id){
        LOGGER.info("code_id={}", code_id);
        List<CommonVO> results =commonService.getTaskMidCode(code_id);
        LOGGER.debug("Returned list: {}", results);
        return results;
    }

    @PostMapping("/skill/update")
    @ResponseBody
    public String updateUsrSkill(@ModelAttribute ProjectVO project){
        LOGGER.info("user_id={}, project_seq={}", project.getUser_id(), project.getProject_seq());
        try {
            // skill_hist_seq
            int hist_seq = projectMntService.selectMaxSkillSeq(project);
            LOGGER.info("사업 정보 hist_seq: hist_seq={}", hist_seq);
            project.setHist_seq(hist_seq);

            // 사용자 프로젝트별 기술 정보 처리
            projectMntService.updateUsrSkill(project);

        }catch (Exception e){
            LOGGER.debug("기술 정보 처리 실패: user_id={}, project_seq={}", project.getUser_id(), project.getProject_seq(), e.getMessage());
            return "FAIL";
        }
        return "SUCCESS";
    }
}
