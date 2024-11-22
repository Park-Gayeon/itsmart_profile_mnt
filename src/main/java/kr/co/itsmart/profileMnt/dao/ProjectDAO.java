package kr.co.itsmart.profileMnt.dao;

import kr.co.itsmart.profileMnt.vo.ProjectVO;
import kr.co.itsmart.profileMnt.vo.UserSkillVO;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface ProjectDAO {
    

    /* project_seq로 연결되어있는 skill목록을 삭제 */
    @Delete("DELETE FROM TB_USER_SKILL_INFO WHERE USER_ID = #{user_id} AND PROJECT_SEQ = #{project_seq}")
    void deleteUsrSkillInfo(ProjectVO projectVO);

    /* 해당 project_seq 로 매핑되는 데이터들을 삭제 */
    @Delete("DELETE FROM TB_PROJECT_INFO WHERE USER_ID = #{user_id} AND PROJECT_SEQ = #{project_seq}")
    void deleteUsrProjectInfo(ProjectVO projectVO);
    
    /* 직원 사업경력 수정 */
    void updateUsrProjectInfo(ProjectVO projectVO);

    /* 직원 사업경력 이력 등록 */
    void insertUsrProjectInfoHist(ProjectVO projectVO);

    /* 기술 이력 max seq 추출 */
    @Select("SELECT COALESCE(MAX(HIST_SEQ) + 1, 1) AS HIST_SEQ FROM TB_USER_SKILL_INFO_HIST WHERE USER_ID = #{user_id} AND PROJECT_SEQ = #{project_seq}")
    int selectSkMaxSeq(ProjectVO projectVO);

    /* 기술 정보 등록 */
    void updateUsrSkillInfo(UserSkillVO skill);
    
    /* 기술 정보 이력 등록 */
    void insertUsrSkillInfoHist(UserSkillVO skill);
}
