package kr.co.itsmart.projectdemo.service;

import kr.co.itsmart.projectdemo.vo.CommonVO;

import java.util.List;

public interface CommonService {

    /* hist seq 생성 */
    int maxHistSeq(String user_id);

    /* code_group_id로 list 조회 */
    List<CommonVO> selectCodeList(String code_group_id);
}