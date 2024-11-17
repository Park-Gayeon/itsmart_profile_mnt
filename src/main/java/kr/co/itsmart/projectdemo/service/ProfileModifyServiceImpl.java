package kr.co.itsmart.projectdemo.service;

import kr.co.itsmart.projectdemo.dao.ProfileDAO;
import kr.co.itsmart.projectdemo.vo.ProfileVO;
import kr.co.itsmart.projectdemo.vo.ProjectVO;
import kr.co.itsmart.projectdemo.vo.QualificationVO;
import kr.co.itsmart.projectdemo.vo.WorkExperienceVO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

@Service
public class ProfileModifyServiceImpl implements ProfileModifyService{
    private final ProfileDAO profileDAO;

    public ProfileModifyServiceImpl(ProfileDAO profileDAO) {
        this.profileDAO = profileDAO;
    }

    @Override
    @Transactional
    public boolean updateUsrProfileInfo(ProfileVO profileVO) {
        try {
            // UPDATE PROFILE INFO
            boolean update = profileDAO.updateUsrProfileInfo(profileVO);

            // CREATE HIST
            boolean create = profileDAO.insertUsrProfileInfoHist(profileVO);

            return update && create;
        } catch (Exception e){
            System.out.println("updateUsrProfileInfo 실패: " + e.getMessage());
            return false;
        }
    }

    @Override
    @Transactional
    public void updateUsrProject(ProfileVO profile) {
        // DELETE TB
        String user_id = profile.getUser_id();
        int hist_seq = profile.getHist_seq();
        profileDAO.deleteUsrProjectInfo(user_id);

        for(ProjectVO project : profile.getProjectList()){
            try {
                project.setUser_id(user_id);
                project.setHist_seq(hist_seq);
                // UPDATE(=INSERT) TB
                profileDAO.updateUsrProjectInfo(project);
                // CREATE HIST
                profileDAO.insertUsrProjectInfoHist(project);
            } catch (Exception e){
                System.out.println("updateUsrProject 실패: " + e.getMessage());
                TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                throw e;
            }
        }
    }

    @Override
    @Transactional
    public void updateUsrQualification(ProfileVO profile) {
        // DELETE TB
        String user_id = profile.getUser_id();
        int hist_seq = profile.getHist_seq();
        profileDAO.deleteUsrQualificationInfo(user_id);

        for(QualificationVO qualification : profile.getQualificationList()){
            try{
                qualification.setUser_id(user_id);
                qualification.setHist_seq(hist_seq);
                // UPDATE(=INSERT) TB
                profileDAO.updateUsrQualificationInfo(qualification);
                // CREATE HIST
                profileDAO.insertUsrQualificationInfoHist(qualification);
            } catch (Exception e){ // try-catch 문이 있는 경우 @Transaction rollback 이 적용 되지 않을 수 있어 수동 으로 rollback
                System.out.println("updateUsrQualification 실패: " + e.getMessage());
                TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                throw e;
            }
        }
    }

    @Override
    @Transactional
    public void updateUsrWorkExperience(ProfileVO profile) {
        // DELETE TB
        String user_id = profile.getUser_id();
        int hist_seq = profile.getHist_seq();
        profileDAO.deleteUsrWorkInfo(user_id);

        for(WorkExperienceVO work : profile.getWorkExperienceList()){
            try {
                work.setUser_id(user_id);
                work.setHist_seq(hist_seq);
                // UPDATE(=INSERT) TB
                profileDAO.updateUsrWorkInfo(work);
                // CREATE HIST
                profileDAO.insertUsrWorkInfoHist(work);
            } catch (Exception e){
                System.out.println("updateUsrWorkExperience 실패: " + e.getMessage());
                TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                throw e;
            }
        }
    }
}
