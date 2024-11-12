package kr.co.itsmart.projectdemo.service;

import kr.co.itsmart.projectdemo.dao.ProfileDAO;
import kr.co.itsmart.projectdemo.vo.ProfileVO;
import kr.co.itsmart.projectdemo.vo.ProjectVO;
import org.springframework.stereotype.Service;

@Service
public class ProfileServiceImpl implements ProfileService{
    private final ProfileDAO profileDAO;

    public ProfileServiceImpl(ProfileDAO profileDAO) {
        this.profileDAO = profileDAO;
    }

    @Override
    public ProfileVO selectDetailInfo(String user_id){
        return profileDAO.selectDetailInfo(user_id);
    }

    @Override
    public ProjectVO selectUsrSkillList(ProjectVO tmpVO) {
        return profileDAO.selectUsrSkillList(tmpVO);
    }
}
