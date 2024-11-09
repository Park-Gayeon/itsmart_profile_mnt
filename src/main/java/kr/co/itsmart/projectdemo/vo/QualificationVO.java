package kr.co.itsmart.projectdemo.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class QualificationVO {
    private String user_id; // 직원 아이디
    private int qualification_seq; // 자격증 순번
    private String qualification_nm; // 자격증 명
    private String issuer; // 발행기관
    private String acquisition_date; // 취득일자
    private String expiry_date; // 만기일자
    private String is_expired; // 만기여브
    private String use_yn; // 사용여부

    // 이력 관리
    private int hist_seq; // 이력 순번

    // meta_data
    private String created_date; // 생성일시
    private String modified_date; // 수정일시
    private String creator; // 생성자
    private String modifier; // 수정자

}
