package kr.co.itsmart.profileMnt.vo;

import java.math.BigDecimal;

public class EduVO {
    private String user_id; // 직원 아이디
    private int school_seq; // 학교 순번
    private String school_gubun; //학력 구분
    private String school_nm; // 학교명
    private String school_start_date; // 입학일자
    private String school_end_date; // 졸업일자
    private String major; // 주전공
    private String double_major; // 복수전공
    private BigDecimal total_grade; // 졸업학점
    private BigDecimal standard_grade; // 기준학점
    private String grad_status; // 졸업상태
    private String created_date; // 생성일시
    private String modified_date; // 수정일시
    private String creator; // 생성자
    private String modifier; // 수정자

    // 이력관리
    private int hist_seq; // 이력 순번

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public int getSchool_seq() {
        return school_seq;
    }

    public void setSchool_seq(int school_seq) {
        this.school_seq = school_seq;
    }

    public String getSchool_gubun() {
        return school_gubun;
    }

    public void setSchool_gubun(String school_gubun) {
        this.school_gubun = school_gubun;
    }

    public String getSchool_nm() {
        return school_nm;
    }

    public void setSchool_nm(String school_nm) {
        this.school_nm = school_nm;
    }

    public String getSchool_start_date() {
        return school_start_date;
    }

    public void setSchool_start_date(String school_start_date) {
        this.school_start_date = school_start_date;
    }

    public String getSchool_end_date() {
        return school_end_date;
    }

    public void setSchool_end_date(String school_end_date) {
        this.school_end_date = school_end_date;
    }

    public String getMajor() {
        return major;
    }

    public void setMajor(String major) {
        this.major = major;
    }

    public String getDouble_major() {
        return double_major;
    }

    public void setDouble_major(String double_major) {
        this.double_major = double_major;
    }

    public BigDecimal getTotal_grade() {
        return total_grade;
    }

    public void setTotal_grade(BigDecimal total_grade) {
        this.total_grade = total_grade;
    }

    public BigDecimal getStandard_grade() {
        return standard_grade;
    }

    public void setStandard_grade(BigDecimal standard_grade) {
        this.standard_grade = standard_grade;
    }

    public String getGrad_status() {
        return grad_status;
    }

    public void setGrad_status(String grad_status) {
        this.grad_status = grad_status;
    }

    public String getCreated_date() {
        return created_date;
    }

    public void setCreated_date(String created_date) {
        this.created_date = created_date;
    }

    public String getModified_date() {
        return modified_date;
    }

    public void setModified_date(String modified_date) {
        this.modified_date = modified_date;
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator;
    }

    public String getModifier() {
        return modifier;
    }

    public void setModifier(String modifier) {
        this.modifier = modifier;
    }

    public int getHist_seq() {
        return hist_seq;
    }

    public void setHist_seq(int hist_seq) {
        this.hist_seq = hist_seq;
    }
}
