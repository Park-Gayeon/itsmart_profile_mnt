package kr.co.itsmart.projectdemo.service;

import kr.co.itsmart.projectdemo.vo.ProfileVO;
import kr.co.itsmart.projectdemo.vo.ProjectVO;

public interface ProfileDetailService {
    /* 프로필 조회(상세) */
    ProfileVO selectUsrProfileDetail(String user_id);

    /* 프로필 조회(기술) */
    ProjectVO selectUsrSkillList(ProjectVO tmpVO);
}
