package kr.co.itsmart.profileMnt.service;

import kr.co.itsmart.profileMnt.vo.ProfileVO;
import kr.co.itsmart.profileMnt.vo.ProjectVO;

public interface ProfileDetailService {
    /* 프로필 조회(상세) */
    ProfileVO selectUsrProfileDetail(String user_id);

    /* 프로필 조회(기술) */
    ProjectVO selectUsrSkillList(ProjectVO tmpVO);
}
