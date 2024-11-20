package kr.co.itsmart.projectdemo.service;

import kr.co.itsmart.projectdemo.vo.ProfileVO;

public interface ProjectMntService {
    /* 사업 이력 테이블 hist_seq 조회 */
    int selectMaxSeq(String user_id);

    /* 프로필 수정(사업경력) */
    void updateUsrProject(ProfileVO profile);

    /* 사업 테이블 max(project_seq) 조회 */
    int getProjectMaxSeq(String user_id);

    /* 사업경력 계산 */
    int calcTotalMonth(String user_id);
}
