package kr.co.itsmart.profileMnt.service;

import kr.co.itsmart.profileMnt.dao.ProfileDAO;
import kr.co.itsmart.profileMnt.vo.EduVO;
import kr.co.itsmart.profileMnt.vo.ProfileVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ProfileMntServiceImpl implements ProfileMntService {
    private final Logger LOGGER = LoggerFactory.getLogger(this.getClass());
    private final ProfileDAO profileDAO;

    public ProfileMntServiceImpl(ProfileDAO profileDAO) {
        this.profileDAO = profileDAO;
    }

    @Override
    public ProfileVO getUsrProfileDetail(String user_id) {
        return profileDAO.getUsrProfileDetail(user_id);
    }

    @Override
    public int getMaxHistSeq(String user_id) {
        return profileDAO.getMaxHistSeq(user_id);
    }

    @Override
    @Transactional
    public void updateUsrProfileInfo(ProfileVO profile) {
        String user_id = profile.getUser_id();
        int hist_seq = profile.getHist_seq();

        // UPDATE PROFILE INFO
        profileDAO.updateUsrProfileInfo(profile);
        LOGGER.info("프로필 정보를 수정했습니다: user_id={}", profile.getUser_id());

        // CREATE HIST
        profileDAO.insertUsrProfileInfoHist(profile);
        LOGGER.info("프로필 이력을 생성했습니다: user_id={}, hist_seq={}", profile.getUser_id(), profile.getHist_seq());

        if (profile.getEducationList() == null || profile.getEducationList().isEmpty()){
            LOGGER.info("학력 정보가 비어있습니다. 처리할 데이터가 없습니다: user_id={}", user_id);
        } else {
            // DELETE TB
            LOGGER.info("사용자 학력 정보를 삭제합니다: user_id={}", user_id);
            profileDAO.deleteUsrEducationInfo(user_id);

            for (EduVO edu : profile.getEducationList()){
                edu.setUser_id(user_id);
                edu.setHist_seq(hist_seq);

                // UPDATE(=INSERT)
                LOGGER.info("사용자 학력 정보를 입력합니다: user_id={}, school_nm={}", user_id, edu.getSchool_nm());
                profileDAO.updateUsrEducationInfo(edu);

                // CREATE HIST
                profileDAO.insertUsrEducationInfoHist(edu);
                LOGGER.info("사용자 학력 정보 이력을 생성했습니다: user_id={}, hist_seq={}", user_id, hist_seq);
            }
        }
    }
}

