package kr.co.itsmart.profileMnt.service;

import kr.co.itsmart.profileMnt.dao.ScheduleDAO;
import kr.co.itsmart.profileMnt.vo.ProfileVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ScheduleServiceImpl implements ScheduleService {
    private final Logger LOGGER = LoggerFactory.getLogger(this.getClass());
    private final ScheduleDAO scheduleDAO;

    public ScheduleServiceImpl(ScheduleDAO scheduleDAO) {
        this.scheduleDAO = scheduleDAO;
    }

    @Override
    public int getListCnt(ProfileVO profile) {
        return scheduleDAO.getListCnt(profile);
    }

    @Override
    public List<ProfileVO> getProjectList(ProfileVO profile) {
        return scheduleDAO.getProjectList(profile);
    }

    @Override
    public List<ProfileVO> getUsersInfoList(String project_nm) {
        return scheduleDAO.getUsersInfoList(project_nm);
    }
}
