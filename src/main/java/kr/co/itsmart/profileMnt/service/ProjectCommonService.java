package kr.co.itsmart.profileMnt.service;

import kr.co.itsmart.profileMnt.vo.ProjectVO;

import java.util.List;

public interface ProjectCommonService {
    int getListCnt(ProjectVO project);
    int getProjectCntPop(ProjectVO project);

    List<ProjectVO> getProjectList(ProjectVO project);
    List<ProjectVO> getProjectListPop(ProjectVO project);

    void insertProjectCommon(ProjectVO project);

    void updateProjectCommon(ProjectVO project);
}
