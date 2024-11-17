package kr.co.itsmart.projectdemo.service;

import kr.co.itsmart.projectdemo.vo.ProfileVO;

public interface ProfileModifyService {

    /* 프로필 수정(인적사항) */
    boolean updateUsrProfileInfo(ProfileVO profileVO);

    /* 프로필 수정(사업경력) */
    void updateUsrProject(ProfileVO profile);

    /* 프로필 수정(자격증) */
    void updateUsrQualification(ProfileVO profile);

    /* 프로필 수정(근무경력) */
    void updateUsrWorkExperience(ProfileVO profile);

}
