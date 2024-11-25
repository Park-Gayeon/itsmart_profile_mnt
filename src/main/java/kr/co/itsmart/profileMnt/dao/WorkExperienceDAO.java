package kr.co.itsmart.profileMnt.dao;

import kr.co.itsmart.profileMnt.vo.WorkExperienceVO;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface WorkExperienceDAO {

    /* 근무경력 이력 테이블 hist_seq 생성 */
    @Select("SELECT COALESCE(MAX(HIST_SEQ) + 1, 1) AS HIST_SEQ FROM TB_WORK_EXPERIENCE_INFO_HIST WHERE USER_ID = #{user_id}")
    int selectMaxHistSeq(String userId);

    /* 근무경력 테이블 데이터 삭제 */
    @Delete("DELETE FROM TB_WORK_EXPERIENCE_INFO WHERE USER_ID = #{user_id}")
    void deleteUsrWorkInfo(String userId);

    /* 프로필 수정(근무경력)*/
    void updateUsrWorkInfo(WorkExperienceVO workExperienceVO);

    /* 근무경력 이력 등록 */
    void insertUsrWorkInfoHist(WorkExperienceVO workExperienceVO);

    /* 근무경력 totalMonth 조회 */
    @Select("SELECT COALESCE(SUM(TIMESTAMPDIFF(MONTH, WORK_START_DATE, WORK_END_DATE)),0) FROM TB_WORK_EXPERIENCE_INFO WHERE USER_ID = #{user_id}")
    int calcWkTotalMonth(String user_id);
}
