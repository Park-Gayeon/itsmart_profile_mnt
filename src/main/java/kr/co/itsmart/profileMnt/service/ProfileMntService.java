package kr.co.itsmart.profileMnt.service;

import kr.co.itsmart.profileMnt.vo.ProfileVO;

public interface ProfileMntService {
    ProfileVO selectUsrProfileDetail(String user_id);
    int selectMaxHistSeq(String user_id);

    void updateUsrProfileInfo(ProfileVO profileVO);

}
