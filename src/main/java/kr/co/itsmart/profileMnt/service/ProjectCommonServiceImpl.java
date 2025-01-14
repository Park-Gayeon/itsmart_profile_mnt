package kr.co.itsmart.profileMnt.service;

import kr.co.itsmart.profileMnt.configuration.handler.CustomException;
import kr.co.itsmart.profileMnt.dao.ProjectCommonDAO;
import kr.co.itsmart.profileMnt.vo.ProjectVO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ProjectCommonServiceImpl implements ProjectCommonService {
    private final ProjectCommonDAO projectCommonDAO;

    public ProjectCommonServiceImpl(ProjectCommonDAO projectCommonDAO) {
        this.projectCommonDAO = projectCommonDAO;
    }

    @Override
    public int getListCnt(ProjectVO project) {
        return projectCommonDAO.getListCnt(project);
    }

    @Override
    public int getProjectCntPop(ProjectVO project) {
        return projectCommonDAO.getProjectCntPop(project);
    }

    @Override
    public List<ProjectVO> getProjectList(ProjectVO project) {
        return projectCommonDAO.getProjectList(project);
    }

    @Override
    public List<ProjectVO> getProjectListPop(ProjectVO project) {
        return projectCommonDAO.getProjectListPop(project);
    }

    @Override
    @Transactional
    public void insertProjectCommon(ProjectVO project) {
        // master_id 중복 체크
        if(projectCommonDAO.checkMasterIdExists(project.getMaster_id())){
            throw new CustomException("신규 생성 중 master_id가 중복되었습니다.\n다시 시도해 주시기 바랍니다.");
        }
        projectCommonDAO.insertProjectCommon(project);
    }

    @Override
    @Transactional
    public void updateProjectCommon(ProjectVO project) {
        // 프로젝트 상태 업데이트
        projectCommonDAO.updateProjectCommon(project);

        // 해당 프로젝트를 참조하는 수행 경력 업데이트
        projectCommonDAO.updateProjectStatus(project.getMaster_id());
    }
}
