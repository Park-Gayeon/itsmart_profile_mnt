package kr.co.itsmart.profileMnt.service;

import kr.co.itsmart.profileMnt.vo.ProfileVO;

import java.util.List;

public interface ScheduleService {
    int getUsrListCnt(ProfileVO profile);

    List<ProfileVO> getUsrProjectList(ProfileVO profile);

    ProfileVO getUsrInfo(String user_id);

}
