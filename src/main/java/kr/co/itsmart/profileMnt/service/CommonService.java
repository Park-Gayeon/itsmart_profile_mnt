package kr.co.itsmart.profileMnt.service;

import kr.co.itsmart.profileMnt.vo.CommonVO;

import java.util.List;
import java.util.Map;

public interface CommonService {

    List<CommonVO> selectCodeList(Map<String, String> params);

    List<CommonVO> getTaskMidCodeList(String code_id);
}
