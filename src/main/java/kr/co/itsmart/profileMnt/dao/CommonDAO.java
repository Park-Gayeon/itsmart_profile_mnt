package kr.co.itsmart.profileMnt.dao;

import kr.co.itsmart.profileMnt.vo.CommonVO;
import kr.co.itsmart.profileMnt.vo.FileVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

@Mapper
public interface CommonDAO {

    /* code_group_id로 list 조회 */
    List<CommonVO> selectCodeList(Map<String, String> params);

    /* TASK 하위 코드 조회 */
    List<CommonVO> getTaskMidCodeList(String code_id);

    /* 파일 테이블 file_seq 조회 */
    @Select("SELECT COALESCE(MAX(FILE_SEQ + 1), 1) AS FILE_SEQ FROM TB_ATTACHMENT_INFO WHERE USER_ID = #{user_id}")
    int selectMaxHistSeq(String user_id);

    /* 파일 등록  */
    void insertUsrFileInfo(FileVO file);
}
