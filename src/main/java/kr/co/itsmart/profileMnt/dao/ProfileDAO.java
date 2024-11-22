package kr.co.itsmart.profileMnt.dao;

import kr.co.itsmart.profileMnt.vo.ProfileVO;
import kr.co.itsmart.profileMnt.vo.ProjectVO;
import kr.co.itsmart.profileMnt.vo.QualificationVO;
import kr.co.itsmart.profileMnt.vo.WorkExperienceVO;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

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
    void updateUsrQualificationInfo(QualificationVO qualificationVO);
    void updateUsrWorkInfo(WorkExperienceVO workExperienceVO);

    /*이력 등록*/
    boolean insertUsrProfileInfoHist(ProfileVO profileVO);

    void insertUsrQualificationInfoHist(QualificationVO qualificationVO);
    void insertUsrWorkInfoHist(WorkExperienceVO workExperienceVO);

    /* TB 데이터 삭제 */
    @Delete("DELETE FROM TB_USER_QUALIFICATION_INFO WHERE USER_ID = #{user_id}")
    void deleteUsrQualificationInfo(String userId);
    @Delete("DELETE FROM TB_WORK_EXPERIENCE_INFO WHERE USER_ID = #{user_id}")
    void deleteUsrWorkInfo(String userId);

    /* TB hist_seq 생성 */
    @Select("SELECT COALESCE(MAX(HIST_SEQ) + 1, 0) AS HIST_SEQ FROM TB_USER_PROFILE_INFO_HIST WHERE USER_ID = #{user_id}")
    int selectPfMaxSeq(String userId);
    @Select("SELECT COALESCE(MAX(HIST_SEQ) + 1, 1) AS HIST_SEQ FROM TB_PROJECT_INFO_HIST WHERE USER_ID = #{user_id}")
    int selectPjMaxSeq(String userId);
    @Select("SELECT COALESCE(MAX(HIST_SEQ) + 1, 1) AS HIST_SEQ FROM TB_USER_QUALIFICATION_INFO_HIST WHERE USER_ID = #{user_id}")
    int selectQlMaxSeq(String userId);
    @Select("SELECT COALESCE(MAX(HIST_SEQ) + 1, 1) AS HIST_SEQ FROM TB_WORK_EXPERIENCE_INFO_HIST WHERE USER_ID = #{user_id}")
    int selectWkMaxSeq(String userId);

    /* project max seq 조회 */
    @Select("SELECT COALESCE(MAX(PROJECT_SEQ), 0) AS PROJECT_SEQ FROM TB_PROJECT_INFO WHERE USER_ID = #{user_id}")
    int getProjectMaxSeq(String userId);

    /* 사업경력 totalMonth 조회 */
    @Select("SELECT SUM(TIMESTAMPDIFF(MONTH, PROJECT_START_DATE, PROJECT_END_DATE)) FROM TB_PROJECT_INFO WHERE USER_ID = #{user_id} AND USE_YN ='Y'")
    int calcPjTotalMonth(String user_id);

    /* 근무경력 totalMonth 조회 */
    @Select("SELECT SUM(TIMESTAMPDIFF(MONTH, WORK_START_DATE, WORK_END_DATE)) FROM TB_WORK_EXPERIENCE_INFO WHERE USER_ID = #{user_id}")
    int calcWkTotalMonth(String user_id);

}
