package kr.co.itsmart.projectdemo.service;

import kr.co.itsmart.projectdemo.dao.ProfileDAO;
import kr.co.itsmart.projectdemo.vo.ProfileVO;
import kr.co.itsmart.projectdemo.vo.ProjectVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ProjectMntServiceImpl implements ProjectMntService{
    private static final Logger LOGGER = LoggerFactory.getLogger(ProjectMntServiceImpl.class);
    private final ProfileDAO profileDAO;
    public ProjectMntServiceImpl(ProfileDAO profileDAO){
        this.profileDAO = profileDAO;
    }

    @Override
    public int selectMaxSeq(String user_id) {
        return profileDAO.selectPjMaxSeq(user_id);
    }

    @Override
    @Transactional
    public void updateUsrProject(ProfileVO profile) {
        String user_id = profile.getUser_id();
        int hist_seq = profile.getHist_seq();
        
        if(profile.getProjectList() == null || profile.getProjectList().isEmpty()){
            LOGGER.info("사업 정보가 비어있습니다. 처리할 데이터가 없습니다: user_id={}", user_id);
            return;
        }

        for(ProjectVO project : profile.getProjectList()){
            project.setUser_id(user_id);
            project.setHist_seq(hist_seq);

            // UPSERT
            LOGGER.info("사업 정보를 입력 및 수정합니다: user_id={}, project_seq={}, project_nm={}", user_id, project.getProject_seq(), project.getProject_nm());
            profileDAO.updateUsrProjectInfo(project);

            // CREATE HIST
            profileDAO.insertUsrProjectInfoHist(project);
            LOGGER.info("사업 정보 이력을 생성했습니다: user_id={}, hist_seq={}", user_id, hist_seq);
            
        }
    }
    @Override
    public int getProjectMaxSeq(String user_id) {
        return profileDAO.getProjectMaxSeq(user_id);
    }
}
