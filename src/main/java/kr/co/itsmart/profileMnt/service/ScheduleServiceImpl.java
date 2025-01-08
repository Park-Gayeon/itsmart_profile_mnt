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
    public int getUsrListCnt(ProfileVO profile) {
        return scheduleDAO.getUsrListCnt(profile);
    }

    @Override
    public List<ProfileVO> getUsrProjectList(ProfileVO profile) {
        return scheduleDAO.getUsrProjectList(profile);
    }

    @Override
    public ProfileVO getUsrInfo(String user_id) {
        return scheduleDAO.getUsrInfo(user_id);
    }
}
