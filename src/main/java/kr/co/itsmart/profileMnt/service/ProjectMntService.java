package kr.co.itsmart.profileMnt.service;

import kr.co.itsmart.profileMnt.vo.ProfileVO;
import kr.co.itsmart.profileMnt.vo.ProjectVO;

public interface ProjectMntService {
    int getProjectMaxSeq(String user_id);

    int getMaxHistSeq(String user_id);

    int getMaxSkillSeq(ProjectVO project);

    void updateUsrProject(ProfileVO profile);

    ProjectVO getUsrSkillList(ProjectVO project);

    void updateUsrSkill(ProjectVO project);

    int calcTotalMonth(String user_id);

}
