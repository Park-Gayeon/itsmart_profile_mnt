package kr.co.itsmart.profileMnt.service;

import kr.co.itsmart.profileMnt.vo.ProfileVO;

public interface ProfileDetailService {
    ProfileVO selectUsrProfileDetail(String user_id);
}
