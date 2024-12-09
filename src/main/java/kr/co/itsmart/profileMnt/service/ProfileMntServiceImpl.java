package kr.co.itsmart.profileMnt.service;

import kr.co.itsmart.profileMnt.dao.ProfileDAO;
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
    public ProfileVO selectUsrProfileDetail(String user_id) {
        return profileDAO.selectUsrProfileDetail(user_id);
    }

    @Override
    public int selectMaxHistSeq(String user_id) {
        return profileDAO.selectMaxHistSeq(user_id);
    }

    @Override
    @Transactional
    public void updateUsrProfileInfo(ProfileVO profile) {
        // UPDATE PROFILE INFO
        profileDAO.updateUsrProfileInfo(profile);
        LOGGER.info("프로필 정보를 수정했습니다: user_id={}", profile.getUser_id());

        // CREATE HIST
        profileDAO.insertUsrProfileInfoHist(profile);
        LOGGER.info("프로필 이력을 생성했습니다: user_id={}, hist_seq={}", profile.getUser_id(), profile.getHist_seq());
    }

}

