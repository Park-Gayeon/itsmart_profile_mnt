package kr.co.itsmart.profileMnt.dao;

import kr.co.itsmart.profileMnt.vo.ProjectVO;
import kr.co.itsmart.profileMnt.vo.UserSkillVO;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface ProjectDAO {
    /* max(project_seq) 조회 */
    @Select("SELECT COALESCE(MAX(PROJECT_SEQ), 0) AS PROJECT_SEQ FROM TB_PROJECT_INFO WHERE USER_ID = #{user_id}")
    int getProjectMaxSeq(String user_id);

    /* 사업 이력 테이블 hist_seq 생성 */
    @Select("SELECT COALESCE(MAX(HIST_SEQ) + 1, 1) AS HIST_SEQ FROM TB_PROJECT_INFO_HIST WHERE USER_ID = #{user_id}")
    int getMaxHistSeq(String userId);

    /* project_seq 로 연결된 skill 목록 삭제 */
    @Delete("DELETE FROM TB_USER_SKILL_INFO WHERE USER_ID = #{user_id} AND PROJECT_SEQ = #{project_seq}")
    void deleteUsrSkillInfo(ProjectVO project);

    /* project_seq 조건 부합 데이터 삭제 */
    @Delete("DELETE FROM TB_PROJECT_INFO WHERE USER_ID = #{user_id} AND PROJECT_SEQ = #{project_seq}")
    void deleteUsrProjectInfo(ProjectVO project);

    /* 전체 project 에 대한 skill 목록 삭제 */
    @Delete("DELETE FROM TB_USER_SKILL_INFO WHERE USER_ID = #{user_id}")
    void deleteUsrAllSkillInfo(String user_id);

    /* 전체 project 삭제 */
    @Delete("DELETE FROM TB_PROJECT_INFO WHERE USER_ID = #{user_id}")
    void deleteUsrAllProjectInfo(String user_id);

    /* 프로필 수정(사업경력) */
    void updateUsrProjectInfo(ProjectVO project);

    /* 사업경력 이력 등록 */
    void insertUsrProjectInfoHist(ProjectVO project);

    /* 기술 정보 조회 */
    ProjectVO getUsrSkillList(ProjectVO project);

    /* 기술 이력 테이블 hist_seq 생성 */
    @Select("SELECT COALESCE(MAX(HIST_SEQ) + 1, 1) AS HIST_SEQ FROM TB_USER_SKILL_INFO_HIST WHERE USER_ID = #{user_id} AND PROJECT_SEQ = #{project_seq}")
    int getSkMaxSeq(ProjectVO projectVO);

    /* 기술 정보 등록 */
    void updateUsrSkillInfo(UserSkillVO skill);

    /* 기술 정보 이력 등록 */
    void insertUsrSkillInfoHist(UserSkillVO skill);

    /* 사업경력 totalMonth 조회 */
    int calcTotalMonth(String input_user_id);
}
