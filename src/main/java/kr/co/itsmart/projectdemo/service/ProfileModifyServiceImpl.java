package kr.co.itsmart.projectdemo.service;

import kr.co.itsmart.projectdemo.dao.ProfileDAO;
import org.springframework.stereotype.Service;

@Service
public class ProfileModifyServiceImpl implements ProfileModifyService{
    private final ProfileDAO profileDAO;

    public ProfileModifyServiceImpl(ProfileDAO profileDAO) {
        this.profileDAO = profileDAO;
    }

    @Override
    public int insertUsrProfileHist(String user_id) {
        return 0;
    }

    @Override
    public int insertUsrQualificationHist() {
        return 0;
    }

    @Override
    public int insertUsrWorkExperienceHist() {
        return 0;
    }

    @Override
    public int insertUsrProjectHist() {
        return 0;
    }

    @Override
    public int inserUsrSkillHist() {
        return 0;
    }

    @Override
    public int updateUsrProfileInfo(String user_id) {
        return 0;
    }

    @Override
    public int updateUsrProfileImage() {
        return 0;
    }

    @Override
    public int updateUsrQualification() {
        return 0;
    }

    @Override
    public int updateUsrWorkExperience() {
        return 0;
    }

    @Override
    public int updateUsrProject() {
        return 0;
    }

    @Override
    public int updateUsrSkill() {
        return 0;
    }
}
