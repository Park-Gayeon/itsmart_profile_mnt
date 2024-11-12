package kr.co.itsmart.projectdemo.service;

import kr.co.itsmart.projectdemo.dao.ProfileDAO;
import kr.co.itsmart.projectdemo.vo.ProfileVO;
import kr.co.itsmart.projectdemo.vo.ProjectVO;
import org.springframework.stereotype.Service;

@Service
public class ProfileDetailServiceImpl implements ProfileDetailService {
    private final ProfileDAO profileDAO;

    public ProfileDetailServiceImpl(ProfileDAO profileDAO) {
        this.profileDAO = profileDAO;
    }

    @Override
    public ProfileVO selectUsrProfileDetail(String user_id){
        return profileDAO.selectUsrProfileDetail(user_id);
    }

    @Override
    public ProjectVO selectUsrSkillList(ProjectVO tmpVO) {
        return profileDAO.selectUsrSkillList(tmpVO);
    }
}
