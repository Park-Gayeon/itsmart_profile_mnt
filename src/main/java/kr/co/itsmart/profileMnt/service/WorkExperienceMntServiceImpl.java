package kr.co.itsmart.profileMnt.service;

import kr.co.itsmart.profileMnt.dao.WorkExperienceDAO;
import kr.co.itsmart.profileMnt.vo.ProfileVO;
import kr.co.itsmart.profileMnt.vo.WorkExperienceVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class WorkExperienceMntServiceImpl implements WorkExperienceMntService{
    private final Logger LOGGER = LoggerFactory.getLogger(this.getClass());
    private final WorkExperienceDAO workExperienceDAO;

    public WorkExperienceMntServiceImpl(WorkExperienceDAO workExperienceDAO) {
        this.workExperienceDAO = workExperienceDAO;
    }
    @Override
    public int selectMaxHistSeq(String user_id) {
        return workExperienceDAO.selectMaxHistSeq(user_id);
    }

    @Override
    @Transactional
    public void updateUsrWorkExperience(ProfileVO profileVO) {
        String user_id = profileVO.getUser_id();
        int hist_seq = profileVO.getHist_seq();

        if(profileVO.getWorkExperienceList() == null || profileVO.getWorkExperienceList().isEmpty()){
            LOGGER.info("근무경력 정보가 비어있습니다. 처리할 데이터가 없습니다: user_id={}", user_id);
            return;
        }

        // DELETE TB
        LOGGER.info("사용자 근무경력 정보를 삭제합니다: user_id={}", user_id);
        workExperienceDAO.deleteUsrWorkInfo(user_id);

        for(WorkExperienceVO work : profileVO.getWorkExperienceList()){
            work.setUser_id(user_id);
            work.setHist_seq(hist_seq);

            // UPDATE(=INSERT)
            LOGGER.info("사용자 근무경력 정보를 입력합니다: user_id={}, work_place", user_id, work.getWork_place());
            workExperienceDAO.updateUsrWorkInfo(work);

            // CREATE HIST
            workExperienceDAO.insertUsrWorkInfoHist(work);
            LOGGER.info("사용자 근무경력 정보 이력을 생성했습니다: user_id={}", user_id);
        }
    }

    @Override
    public int calcTotalMonth(String user_id) {
        return workExperienceDAO.calcWkTotalMonth(user_id);
    }
}
