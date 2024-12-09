package kr.co.itsmart.profileMnt.dao;

import kr.co.itsmart.profileMnt.vo.CommonVO;
import kr.co.itsmart.profileMnt.vo.FileVO;
import kr.co.itsmart.profileMnt.vo.LoginVO;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@Mapper
public interface CommonDAO {

    /* code_group_id로 list 조회 */
    List<CommonVO> selectCodeList(Map<String, String> params);

    /* TASK 하위 코드 조회 */
    List<CommonVO> getTaskMidCodeList(String code_id);

    /* 파일 테이블 file_seq 생성 */
    @Select("SELECT COALESCE(MAX(FILE_SEQ + 1), 1) AS FILE_SEQ FROM TB_ATTACHMENT_INFO WHERE USER_ID = #{user_id}")
    int selectMaxHistSeq(String user_id);

    /* 파일 등록  */
    void insertUsrFileInfo(FileVO file);

    /* 로그인 유저 조회 */
    @Select("SELECT USER_ID, USER_PW, USER_ROLE FROM TB_USER_PROFILE_INFO WHERE USER_ID = #{user_id}")
    Optional<LoginVO> getUsrInfo(String user_id);

    /* 로그인 유저 token 조회 */
    @Select("SELECT TOKEN FROM TB_USER_REFRESH_TOKEN_INFO WHERE USER_ID = #{user_id}")
    String getUsrRefreshToken(String user_id);

    /* Refresh Token 제거 */
    @Delete("DELETE FROM TB_USER_REFRESH_TOKEN_INFO WHERE USER_ID = #{user_id}")
    void removeUsrRefreshToken(String user_id);

    /* Refresh Token 저장 */
    void saveUsrRefreshToken(Map<String, String> params);

}
