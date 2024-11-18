package kr.co.itsmart.projectdemo.service;

import kr.co.itsmart.projectdemo.dao.ProfileDAO;
import kr.co.itsmart.projectdemo.vo.ProfileVO;
import kr.co.itsmart.projectdemo.vo.QualificationVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class QualificationMntServiceImpl implements QualificationMntService {
    private static final Logger LOGGER = LoggerFactory.getLogger(QualificationMntServiceImpl.class);
    private final ProfileDAO profileDAO;

    public QualificationMntServiceImpl(ProfileDAO profileDAO) {
        this.profileDAO = profileDAO;
    }

    @Override
    public int selectMaxSeq(String user_id) {
        return profileDAO.selectQlMaxSeq(user_id);
    }

    @Override
    @Transactional
    public void updateUsrQualification(ProfileVO profile) {
        String user_id = profile.getUser_id();
        int hist_seq = profile.getHist_seq();

        if (profile.getQualificationList() == null || profile.getQualificationList().isEmpty()) {
            LOGGER.info("자격 정보가 비어있습니다. 처리할 데이터가 없습니다: user_id={}", user_id);
            return;
        }

        // DELETE TB
        LOGGER.info("사용자 자격증 정보를 삭제합니다: user_id={}", user_id);
        profileDAO.deleteUsrQualificationInfo(user_id);

        for (QualificationVO qualification : profile.getQualificationList()) {
            qualification.setUser_id(user_id);
            qualification.setHist_seq(hist_seq);

            // UPDATE(=INSERT)
            LOGGER.info("사용자 자격증 정보를 입력합니다: user_id={}, qualification_nm={}", user_id, qualification.getQualification_nm());
            profileDAO.updateUsrQualificationInfo(qualification);

            // CREATE HIST
            profileDAO.insertUsrQualificationInfoHist(qualification);
            LOGGER.info("사용자 자격증 정보 이력을 생성했습니다: user_id={}, hist_seq={}", user_id, hist_seq);
        }
    }
}
