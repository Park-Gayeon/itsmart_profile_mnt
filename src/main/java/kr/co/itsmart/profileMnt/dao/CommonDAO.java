package kr.co.itsmart.profileMnt.dao;

import kr.co.itsmart.profileMnt.vo.CommonVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface CommonDAO {

    /* code_group_id로 list 조회 */
    List<CommonVO> selectCodeList(Map<String, String> params);

    /* TASK 하위 코드 조회 */
    List<CommonVO> getTaskMidCodeList(String code_id);
}
