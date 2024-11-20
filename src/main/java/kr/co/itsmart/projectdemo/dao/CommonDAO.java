package kr.co.itsmart.projectdemo.dao;

import kr.co.itsmart.projectdemo.vo.CommonVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface CommonDAO {

    /* code_group_id로 list 조회 */
    List<CommonVO> selectCodeList(Map<String, String> params);

    /* 업무분류 동적 조회 */
    List<CommonVO> getTaskMidCode(String code_id);
}
