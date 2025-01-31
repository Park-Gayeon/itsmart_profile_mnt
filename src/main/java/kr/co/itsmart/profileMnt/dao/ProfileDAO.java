package kr.co.itsmart.profileMnt.dao;

import kr.co.itsmart.profileMnt.vo.EduVO;
import kr.co.itsmart.profileMnt.vo.ProfileVO;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface ProfileDAO {
    /* 프로필 상세화면 조회 */
    ProfileVO getUsrProfileDetail(String user_id);

    /* 프로필 이력 테이블 hist_seq 생성 */
    @Select("SELECT COALESCE(MAX(HIST_SEQ) + 1, 1) AS HIST_SEQ FROM TB_USER_PROFILE_INFO_HIST WHERE USER_ID = #{user_id}")
    int getMaxHistSeq(String userId);

    /* 프로필 수정(인적사항)*/
    void updateUsrProfileInfo(ProfileVO profileVO);

    /* 프로필 이력 등록 */
    void insertUsrProfileInfoHist(ProfileVO profileVO);

    /* 학력 테이블 데이터 삭제 */
    @Delete("DELETE FROM TB_USER_EDUCATION_INFO WHERE USER_ID = #{user_id}")
    void deleteUsrEducationInfo(String user_id);

    /* 프로필 수정(학력) */
    void updateUsrEducationInfo(EduVO edu);

    /* 학력 이력 등록 */
    void insertUsrEducationInfoHist(EduVO edu);

    /*관리자 : 직원 목록 조회*/
    List<ProfileVO> getUsrProfileInfoList(ProfileVO profileVO);
    
    /* 관리자 : 직원 목록 전체 조회 */
    List<ProfileVO> getUsrProfileNotPagingInfoList();

    /* 직원 목록 조회 건수 */
    int getUsrProfileInfoCnt(ProfileVO profile);

    /* USER_ID 중복 체크 */
    boolean checkUsrExists(String user_id);

    /* 신규 직원 프로필 등록 */
    void insertUsrProfile(ProfileVO profile);

}
