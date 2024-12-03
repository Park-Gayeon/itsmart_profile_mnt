package kr.co.itsmart.profileMnt.dao;

import kr.co.itsmart.profileMnt.vo.LoginVO;
import kr.co.itsmart.profileMnt.vo.ProfileVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Optional;

@Mapper
public interface ProfileDAO {
    /* 프로필 상세화면 조회 */
    ProfileVO selectUsrProfileDetail(String user_id);

    /* 프로필 이력 테이블 hist_seq 생성 */
    @Select("SELECT COALESCE(MAX(HIST_SEQ) + 1, 1) AS HIST_SEQ FROM TB_USER_PROFILE_INFO_HIST WHERE USER_ID = #{user_id}")
    int selectMaxHistSeq(String userId);

    /* 프로필 수정(인적사항)*/
    void updateUsrProfileInfo(ProfileVO profileVO);

    /* 프로필 이력 등록 */
    void insertUsrProfileInfoHist(ProfileVO profileVO);

    /*관리자 : 직원 목록 조회*/
    List<ProfileVO> getUsrProfileInfoList(ProfileVO profileVO);

    /* 직원 목록 조회 건수 */
    int getUsrProfileInfoCnt(ProfileVO profile);

    /* USER_ID 중복 체크 */
    boolean checkUsrExists(String user_id);

    /* 신규 직원 프로필 등록 */
    void insertUsrProfile(ProfileVO profile);

    /* 로그인 유저 조회 */
    @Select("SELECT USER_ID, USER_PW FROM TB_USER_PROFILE_INFO WHERE USER_ID = #{user_id}")
    Optional<LoginVO> getUsrInfo(String user_id);
}
