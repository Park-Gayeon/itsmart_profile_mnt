package kr.co.itsmart.profileMnt.dao;

import kr.co.itsmart.profileMnt.vo.ProjectVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ProjectCommonDAO {
    /* 프로젝트 관리 : 목록 건수 조회 */
    int getListCnt(ProjectVO project);
    /* 프로젝트 등록 : 팝업 목록 건수 조회 */
    int getProjectCntPop(ProjectVO project);

    /* 프로젝트 관리 : 목록 조회 */
    List<ProjectVO> getProjectList(ProjectVO project);

    /* 프로젝트 등록 : 팝업 목록 조회 */
    List<ProjectVO> getProjectListPop(ProjectVO project);

    /* 프로젝트 관리 : 신규 프로젝트 등록 */
    void insertProjectCommon(ProjectVO project);
    
    /* 프로젝트 관리 : 프로젝트 사용여부 업데이트 */
    void updateProjectCommon(ProjectVO project);

    /* 프로젝트 관리 : 프로젝트 일괄 업데이트[master_id] */
    void updateProjectStatus(String master_id);

    /* 프로젝트 관리 : MASTER_ID 중복 여부 확인 */
    boolean checkMasterIdExists(String master_id);
}