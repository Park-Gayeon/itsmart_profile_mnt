package kr.co.itsmart.profileMnt.service;

import kr.co.itsmart.profileMnt.vo.ProfileVO;

public interface WorkExperienceMntService {
    int selectMaxHistSeq(String user_id);

    void updateUsrWorkExperience(ProfileVO profileVO);

    int calcTotalMonth(String user_id);
}
