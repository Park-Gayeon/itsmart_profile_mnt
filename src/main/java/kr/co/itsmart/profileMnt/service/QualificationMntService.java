package kr.co.itsmart.profileMnt.service;

import kr.co.itsmart.profileMnt.vo.ProfileVO;

public interface QualificationMntService {
    int selectMaxHistSeq(String user_id);

    void updateUsrQualification(ProfileVO profile);
}