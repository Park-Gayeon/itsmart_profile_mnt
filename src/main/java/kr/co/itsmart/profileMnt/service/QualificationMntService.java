package kr.co.itsmart.profileMnt.service;

import kr.co.itsmart.profileMnt.vo.ProfileVO;

public interface QualificationMntService {
    /* 자격증 이력 테이블 hist_seq 조회 */
    int selectMaxSeq(String user_id);

    /* 프로필 수정(자격증) */
    void updateUsrQualification(ProfileVO profile);
}
