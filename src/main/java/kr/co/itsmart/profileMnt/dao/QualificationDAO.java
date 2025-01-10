package kr.co.itsmart.profileMnt.dao;

import kr.co.itsmart.profileMnt.vo.QualificationVO;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface QualificationDAO {

    /* 자격증 이력 테이블 hist_seq 생성 */
    @Select("SELECT COALESCE(MAX(HIST_SEQ) + 1, 1) AS HIST_SEQ FROM TB_USER_QUALIFICATION_INFO_HIST WHERE USER_ID = #{user_id}")
    int getMaxHistSeq(String userId);

    /* 자격증 테이블 데이터 삭제 */
    @Delete("DELETE FROM TB_USER_QUALIFICATION_INFO WHERE USER_ID = #{user_id}")
    void deleteUsrQualificationInfo(String userId);

    /* 프로필 수정(자격증) */
    void updateUsrQualificationInfo(QualificationVO qualificationVO);

    /* 자격증 이력 등록 */
    void insertUsrQualificationInfoHist(QualificationVO qualificationVO);
}
