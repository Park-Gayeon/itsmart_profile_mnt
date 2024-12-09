package kr.co.itsmart.profileMnt.service;

import kr.co.itsmart.profileMnt.dao.ProjectDAO;
import kr.co.itsmart.profileMnt.vo.ProfileVO;
import kr.co.itsmart.profileMnt.vo.ProjectVO;
import kr.co.itsmart.profileMnt.vo.UserSkillVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ProjectMntServiceImpl implements ProjectMntService {
    private final Logger LOGGER = LoggerFactory.getLogger(this.getClass());
    private final ProjectDAO projectDAO;

    public ProjectMntServiceImpl(ProjectDAO projectDAO) {
        this.projectDAO = projectDAO;
    }

    @Override
    public int getProjectMaxSeq(String user_id) {
        return projectDAO.getProjectMaxSeq(user_id);
    }

    @Override
    public int selectMaxHistSeq(String user_id) {
        return projectDAO.selectMaxHistSeq(user_id);
    }

    @Override
    public int selectMaxSkillSeq(ProjectVO project) {
        return projectDAO.selectSkMaxSeq(project);
    }

    @Override
    @Transactional
    public void updateUsrProject(ProfileVO profile) {
        String user_id = profile.getUser_id();
        int hist_seq = profile.getHist_seq();

        if (profile.getProjectList() == null || profile.getProjectList().isEmpty()) {
            LOGGER.info("사업 정보가 비어있습니다. 처리할 데이터가 없습니다: user_id={}", user_id);
            return;
        }

        for (ProjectVO project : profile.getProjectList()) {
            project.setUser_id(user_id);
            project.setHist_seq(hist_seq);
            LOGGER.info("========================================================================");
            LOGGER.info("프로젝트명: {}, 사용여부: {}", project.getProject_nm(), project.getUse_yn());
            LOGGER.info("========================================================================");

            if ("N".equals(project.getUse_yn())) {
                LOGGER.info("프로젝트를 삭제합니다. project_nm={}, project_seq={}", project.getProject_nm(), project.getProject_seq());
                projectDAO.deleteUsrSkillInfo(project);
                projectDAO.deleteUsrProjectInfo(project);
            } else {
                // UPSERT
                LOGGER.info("사업 정보를 입력 및 수정합니다: user_id={}, project_seq={}, project_nm={}", user_id, project.getProject_seq(), project.getProject_nm());
                projectDAO.updateUsrProjectInfo(project);

                // CREATE HIST
                projectDAO.insertUsrProjectInfoHist(project);
                LOGGER.info("사업 정보 이력을 생성했습니다: user_id={}, hist_seq={}", user_id, hist_seq);
            }
        }
    }

    @Override
    public ProjectVO selectUsrSkillList(ProjectVO project) {
        return projectDAO.selectUsrSkillList(project);
    }


    @Override
    @Transactional
    public void updateUsrSkill(ProjectVO project) {
        String user_id = project.getUser_id();
        int project_seq = project.getProject_seq();
        int hist_seq = project.getHist_seq();

        if (project.getSkillList() == null || project.getSkillList().isEmpty()) {
            LOGGER.info("기술 정보가 비어있습니다. 처리할 데이터가 없습니다: user_id={}, project_seq={}", user_id, project_seq);
            return;
        }

        // DELETE TB
        LOGGER.info("프로젝트와 관련된 기술 정보를 삭제합니다: user_id={}, project_seq={}", user_id, project_seq);
        projectDAO.deleteUsrSkillInfo(project);

        for (UserSkillVO skill : project.getSkillList()) {
            skill.setUser_id(user_id);
            skill.setProject_seq(project_seq);
            skill.setHist_seq(hist_seq);

            // UPDATE(=INSERT)
            LOGGER.info("기술 정보를 입력합니다: user_id={}, skill_id={}, skill_nm={}", skill.getUser_id(), skill.getSkill_id(), skill.getSkill_nm());
            projectDAO.updateUsrSkillInfo(skill);

            // CREATE HIST
            projectDAO.insertUsrSkillInfoHist(skill);
            LOGGER.info("기술 정보 이력을 생성했습니다: user_id={}, project_seq={}, hist_seq={}", skill.getUser_id(), skill.getProject_seq(), skill.getHist_seq());
        }
    }

    @Override
    public int calcTotalMonth(String user_id) {
        return projectDAO.calcTotalMonth(user_id);
    }
}
