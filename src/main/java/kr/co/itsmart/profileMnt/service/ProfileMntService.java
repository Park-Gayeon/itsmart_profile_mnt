package kr.co.itsmart.profileMnt.service;

import kr.co.itsmart.profileMnt.vo.ProfileVO;

public interface ProfileMntService {
    ProfileVO getUsrProfileDetail(String user_id);
    int getMaxHistSeq(String user_id);

    void updateUsrProfileInfo(ProfileVO profileVO);

}
