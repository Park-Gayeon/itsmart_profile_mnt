package kr.co.itsmart.profileMnt.service;

import kr.co.itsmart.profileMnt.vo.ProfileVO;

import java.util.List;

public interface ScheduleService {
    int getListCnt(ProfileVO profile);

    List<ProfileVO> getProjectList(ProfileVO profile);


    List<ProfileVO> getUsersInfoList(ProfileVO profile);

}
