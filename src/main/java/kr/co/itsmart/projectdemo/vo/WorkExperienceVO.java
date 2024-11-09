package kr.co.itsmart.projectdemo.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class WorkExperienceVO {
    private String user_id; // 직원 아이디
    private int work_seq; // 근무지 순번
    private String work_place; // 근무지
    private String work_start_date; // 입사일자
    private String work_end_date; // 퇴사일자
    private String use_yn; // 사용여부

    // 이력 관리
    private int hist_seq; // 이력 순번

    // meta_data
    private String created_date; // 생성일시
    private String modified_date; // 수정일시
    private String creator; // 생성자
    private String modifier; // 수정자

}
