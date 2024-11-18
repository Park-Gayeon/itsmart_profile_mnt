package kr.co.itsmart.projectdemo.dao;

import kr.co.itsmart.projectdemo.vo.CommonVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CommonDAO {

    /* code_group_id로 list 조회 */
    List<CommonVO> selectCodeList(String code_group_id);
}
