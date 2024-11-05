package kr.co.itsmart.projectdemo.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProfileVO {
    private String user_id; // 직원 아이다
    private String user_pw; // 비밀번호
    private String user_nm; // 직원명
    private String user_position; // 직급/직위
    private String user_birth; // 직원 생년월일
    private String user_department; // 소속
    private String hire_date; // 입사일
    private String user_phone; // 휴대전화
    private String user_address; // 주소
    private String user_role; // 권한
    private String use_yn; // 사용여부
    private int file_id; // 파일 아이디
    private String edu1_school_name; // 학력1_학교명
    private String edu1_grad_status; // 학력1_졸업상태
    private String edu1_start_date; // 학력1_입학년월
    private String edu1_end_date; // 학력_졸업년월
    private String edu2_school_name; // 학력2_학교명
    private String edu2_grad_status; // 학력2_졸업상태
    private String edu2_start_date; // 학력2_입학년월
    private String edu2_end_date; // 학력2_졸업년월
    private String edu3_school_name; // 학력3_학교명
    private String edu3_grad_status; // 학력3_졸업상태
    private String edu3_start_date; // 학력3_입학년월
    private String edu3_end_date; // 학력3_졸업년월
    private String major; // 전공
    private String double_major; // 복수전공
    private String total_grade; // 졸업학점
    private String standard_grade; // 기준학점

    // 이력관리
    private int file_seq; // 파일 순번

    // meta_data
    private String created_date; // 생성일시
    private String modified_date; // 수정일시
    private String creator; // 생성자
    private String modifier; /// 수정자
}
