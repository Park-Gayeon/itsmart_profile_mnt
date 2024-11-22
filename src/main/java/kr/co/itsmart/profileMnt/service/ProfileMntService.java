package kr.co.itsmart.profileMnt.service;

import kr.co.itsmart.profileMnt.vo.ProfileVO;

public interface ProfileMntService {
    int selectMaxHistSeq(String user_id);

    void updateUsrProfileInfo(ProfileVO profileVO);
}
