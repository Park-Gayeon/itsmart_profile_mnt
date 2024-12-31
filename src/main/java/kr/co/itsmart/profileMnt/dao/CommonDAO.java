package kr.co.itsmart.profileMnt.dao;

import kr.co.itsmart.profileMnt.vo.CommonVO;
import kr.co.itsmart.profileMnt.vo.FileVO;
import kr.co.itsmart.profileMnt.vo.LoginVO;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@Mapper
public interface CommonDAO {

    /* code_group_id로 list 조회 */
    List<CommonVO> selectCodeList(Map<String, String> params);

    /* 순수 코드 list 조회 */
    List<CommonVO> selectPureCodeList(String code_id);

    /* TASK 하위 코드 조회 */
    List<CommonVO> getTaskMidCodeList(String code_id);

    /* TASK code 조회 */
    @Select("SELECT CODE_ID FROM TB_COMMON_CODE WHERE CODE_GROUP_ID = 'TASK' AND CODE_VALUE = #{value} AND LEVEL = #{level}")
    String getTaskCodeId(Map<String, Object> map);

    /* 파일 테이블 file_seq 생성 */
    @Select("SELECT COALESCE(MAX(FILE_SEQ + 1), 1) AS FILE_SEQ FROM TB_ATTACHMENT_INFO WHERE USER_ID = #{user_id}")
    int selectMaxHistSeq(String user_id);

    /* 파일 등록  */
    void insertUsrFileInfo(FileVO file);

    /* 로그인 유저 조회 */
    @Select("SELECT USER_ID, USER_PW, USER_ROLE FROM TB_USER_PROFILE_INFO WHERE USER_ID = #{user_id} AND USE_YN = 'Y'")
    Optional<LoginVO> getUsrInfo(String user_id);

    /* 로그인 유저 token 조회 */
    @Select("SELECT TOKEN FROM TB_USER_REFRESH_TOKEN_INFO WHERE USER_ID = #{user_id}")
    String getUsrRefreshToken(String user_id);

    /* Refresh Token 제거 */
    @Delete("DELETE FROM TB_USER_REFRESH_TOKEN_INFO WHERE USER_ID = #{user_id}")
    void removeUsrRefreshToken(String user_id);

    /* Refresh Token 저장 */
    void saveUsrRefreshToken(Map<String, String> params);

    /* Password 변경 저장 */
    void changeUsrPassword(Map<String, String> params);

    /* 회원 삭제 */
    @Update("UPDATE TB_USER_PROFILE_INFO SET USE_YN = 'N' WHERE USER_ID = #{user_id}")
    void deleteUsr(String user_id);

}
