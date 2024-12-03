package kr.co.itsmart.profileMnt.service;

import kr.co.itsmart.profileMnt.vo.LoginVO;
import kr.co.itsmart.profileMnt.vo.ProfileVO;

import java.util.List;
import java.util.Optional;

public interface ProfileInfoService {
    List<ProfileVO> getUsrProfileInfoList(ProfileVO profile);

    int getUsrProfileInfoCnt(ProfileVO profile);

    boolean checkUsrExists(String user_id);

    void insertUsrProfile(ProfileVO profile);

    int selectMaxHistSeq(String user_id);

    Optional<LoginVO> getUsrInfo(String user_id);
}
