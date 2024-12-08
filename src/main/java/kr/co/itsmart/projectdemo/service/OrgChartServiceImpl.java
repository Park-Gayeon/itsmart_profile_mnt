package kr.co.itsmart.profileMnt.service;

import kr.co.itsmart.profileMnt.dao.OrgChartDAO;
import kr.co.itsmart.profileMnt.vo.CommonVO;
import kr.co.itsmart.profileMnt.vo.ProfileVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrgChartServiceImpl implements OrgChartService{
    private final Logger logger = LoggerFactory.getLogger(this.getClass());
    private final OrgChartDAO orgChartDAO;

    public OrgChartServiceImpl(OrgChartDAO orgChartDAO) {
        this.orgChartDAO = orgChartDAO;
    }

    @Override
    public List<CommonVO> getOrgChart() {
        logger.info("getOrgChart 를 조회합니다.");
        return orgChartDAO.getOrgChart();
    }

    @Override
    public List<ProfileVO> getOrgChartUserList() {
        return orgChartDAO.getOrgChartUserList();
    }
}
