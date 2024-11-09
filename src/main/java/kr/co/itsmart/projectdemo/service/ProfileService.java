package kr.co.itsmart.projectdemo.service;

import kr.co.itsmart.projectdemo.vo.ProfileVO;
import kr.co.itsmart.projectdemo.vo.ProjectVO;

public interface ProfileService {
    ProfileVO selectDetailInfo(String user_id);
    ProjectVO selectUsrSkillList(ProjectVO tmpVO);
}
