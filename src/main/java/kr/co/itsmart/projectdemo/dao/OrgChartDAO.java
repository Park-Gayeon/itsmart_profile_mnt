package kr.co.itsmart.profileMnt.dao;

import kr.co.itsmart.profileMnt.vo.CommonVO;
import kr.co.itsmart.profileMnt.vo.ProfileVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface OrgChartDAO {
    /* 조직도 조회 */
    List<CommonVO> getOrgChart();

    /* 조직도 직원 조회 */
    List<ProfileVO> getOrgChartUserList();
}
