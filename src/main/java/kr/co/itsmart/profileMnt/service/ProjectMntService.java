package kr.co.itsmart.profileMnt.service;

import kr.co.itsmart.profileMnt.vo.ProfileVO;
import kr.co.itsmart.profileMnt.vo.ProjectVO;

public interface ProjectMntService {
    int getProjectMaxSeq(String user_id);

    int selectMaxHistSeq(String user_id);

    int selectMaxSkillSeq(ProjectVO project);

    void updateUsrProject(ProfileVO profile);

    ProjectVO selectUsrSkillList(ProjectVO project);

    void updateUsrSkill(ProjectVO project);

    int calcTotalMonth(String user_id);

}
