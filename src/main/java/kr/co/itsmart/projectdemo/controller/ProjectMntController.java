package kr.co.itsmart.projectdemo.controller;

import kr.co.itsmart.projectdemo.service.ProjectMntService;
import kr.co.itsmart.projectdemo.vo.ProfileVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/profile/project/modify")
public class ProjectMntController {
    private static final Logger LOGGER = LoggerFactory.getLogger(ProjectMntController.class);
    private final ProjectMntService projectMntService;

    public ProjectMntController(ProjectMntService projectMntService) {
        this.projectMntService = projectMntService;
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
        for(int i = 0; i<profile.getProjectList().size(); i++){
            LOGGER.info("사업명 project_nm={}", profile.getProjectList().get(i).getProject_nm());
        }
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
}
