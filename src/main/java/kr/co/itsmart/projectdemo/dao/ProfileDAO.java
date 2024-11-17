package kr.co.itsmart.projectdemo.dao;

import kr.co.itsmart.projectdemo.vo.ProfileVO;
import kr.co.itsmart.projectdemo.vo.ProjectVO;
import kr.co.itsmart.projectdemo.vo.QualificationVO;
import kr.co.itsmart.projectdemo.vo.WorkExperienceVO;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ProfileDAO {
    /*직원(관리자 포함) : 프로필 상세화면 조회*/
    ProfileVO selectUsrProfileDetail(@Param("user_id") String user_id);

    /*직원(관리자 포함) : 프로필 상세화면 > 프로젝트 기술 조회*/
    ProjectVO selectUsrSkillList(ProjectVO tmpVO);

    /*관리자 : 직원 프로필 등록*/
    void registUsrProfile(ProfileVO profileVO);

    /*관리자 : 직원 목록 조회*/
    List<ProfileVO> selectUsrProfileInfo(ProfileVO profileVO);

    /*직원 : 프로필 수정*/
    boolean updateUsrProfileInfo(ProfileVO profileVO);
    void updateUsrProjectInfo(ProjectVO projectVO);
    void updateUsrQualificationInfo(QualificationVO qualificationVO);
    void updateUsrWorkInfo(WorkExperienceVO workExperienceVO);

    /*이력 등록*/
    boolean insertUsrProfileInfoHist(ProfileVO profileVO);
    void insertUsrProjectInfoHist(ProjectVO projectVO);
    void insertUsrQualificationInfoHist(QualificationVO qualificationVO);
    void insertUsrWorkInfoHist(WorkExperienceVO workExperienceVO);

    /* TB 데이터 삭제 */
    @Delete("DELETE FROM TB_PROJECT_INFO WHERE USER_ID = #{user_id}")
    void deleteUsrProjectInfo(String userId);
    @Delete("DELETE FROM TB_USER_QUALIFICATION_INFO WHERE USER_ID = #{user_id}")
    void deleteUsrQualificationInfo(String userId);
    @Delete("DELETE FROM TB_WORK_EXPERIENCE_INFO WHERE USER_ID = #{user_id}")
    void deleteUsrWorkInfo(String userId);
}
