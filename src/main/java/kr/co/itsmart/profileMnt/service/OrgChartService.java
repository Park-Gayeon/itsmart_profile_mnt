package kr.co.itsmart.profileMnt.service;

import kr.co.itsmart.profileMnt.vo.CommonVO;
import kr.co.itsmart.profileMnt.vo.ProfileVO;

import java.util.List;

public interface OrgChartService {
    List<CommonVO> getOrgChart();
    List<ProfileVO> getOrgChartUserList();
}
