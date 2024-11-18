package kr.co.itsmart.projectdemo.service;

import kr.co.itsmart.projectdemo.vo.ProfileVO;

public interface WorkExperienceMntService {
    /* 근무경력 이력 테이블 hist_seq 조회 */
    int selectMaxSeq(String user_id);

    /* 프로필 수정(근무경력) */
    void updateUsrWorkExperience(ProfileVO profileVO);
}
