package kr.co.itsmart.projectdemo.service;

import kr.co.itsmart.projectdemo.vo.CommonVO;

import java.util.List;
import java.util.Map;

public interface CommonService {

    /* code_group_id로 list 조회 */
    List<CommonVO> selectCodeList(Map<String, String> params);

    /* 업무분류 동적 조회 */
    List<CommonVO> getTaskMidCode(String code_id);
}
