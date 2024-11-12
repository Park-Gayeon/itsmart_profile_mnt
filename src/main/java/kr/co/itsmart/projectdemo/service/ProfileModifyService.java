package kr.co.itsmart.projectdemo.service;

public interface ProfileModifyService {
    /* 프로필 history 생성 */
    int insertUsrProfileHist(String user_id);
    int insertUsrQualificationHist();
    int insertUsrWorkExperienceHist();
    int insertUsrProjectHist();
    int inserUsrSkillHist();


    /* 프로필 수정(인적사항) */
    int updateUsrProfileInfo(String user_id);

    /* 프로필 사진 file_seq update */
    int updateUsrProfileImage();

    /* 프로필 수정(자격증) */
    int updateUsrQualification();

    /* 프로필 수정(근무경력) */
    int updateUsrWorkExperience();

    /* 프로필 수정(사업경력) */
    int updateUsrProject();

    /* 프로필 수정(기술) */
    int updateUsrSkill();
}
