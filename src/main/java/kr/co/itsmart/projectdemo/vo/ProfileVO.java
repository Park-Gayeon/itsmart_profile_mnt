package kr.co.itsmart.projectdemo.vo;

import java.math.BigDecimal;
import java.util.List;

public class ProfileVO {
    private String user_id; // 직원 아이디
    private String user_pw; // 비밀번호
    private String user_nm; // 직원명
    private String user_position; // 직급/직위 코드
    private String user_position_nm; // 직급/직위명
    private String user_birth; // 직원 생년월일
    private String user_department; // 소속 코드
    private String user_department_nm; // 소속명
    private String hire_date; // 입사일
    private String user_phone; // 휴대전화
    private String user_address; // 주소
    private String user_role; // 권한
    private String use_yn; // 사용여부
    private int file_seq; // 파일 순번
    private String edu1_school_name; // 학력1_학교명
    private String edu1_grad_status; // 학력1_졸업상태
    private String edu1_start_date; // 학력1_입학년월
    private String edu1_end_date; // 학력1_졸업년월
    private String edu1_gubun; // 학력1_구분
    private String edu2_school_name; // 학력2_학교명
    private String edu2_grad_status; // 학력2_졸업상태
    private String edu2_start_date; // 학력2_입학년월
    private String edu2_end_date; // 학력2_졸업년월
    private String edu2_gubun; // 학력2_구분
    private String edu3_school_name; // 학력3_학교명
    private String edu3_grad_status; // 학력3_졸업상태
    private String edu3_start_date; // 학력3_입학년월
    private String edu3_end_date; // 학력3_졸업년월
    private String edu3_gubun; // 학력3_구분
    private String major; // 전공
    private String double_major; // 복수전공
    private BigDecimal total_grade; // 졸업학점
    private BigDecimal standard_grade; // 기준학점

    // 이력관리
    private int hist_seq; // 이력 순번

    // etc
    private String eduGubun; // 학교구분

    private List<ProjectVO> projectList;
    private List<QualificationVO> qualificationList;
    private List<WorkExperienceVO> workExperienceList;
    private FileVO fileInfo;

    // meta_data
    private String created_date; // 생성일시
    private String modified_date; // 수정일시
    private String creator; // 생성자
    private String modifier; /// 수정자

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public String getUser_pw() {
        return user_pw;
    }

    public void setUser_pw(String user_pw) {
        this.user_pw = user_pw;
    }

    public String getUser_nm() {
        return user_nm;
    }

    public void setUser_nm(String user_nm) {
        this.user_nm = user_nm;
    }

    public String getUser_position() {
        return user_position;
    }

    public void setUser_position(String user_position) {
        this.user_position = user_position;
    }

    public String getUser_position_nm() {
        return user_position_nm;
    }

    public void setUser_position_nm(String user_position_nm) {
        this.user_position_nm = user_position_nm;
    }

    public String getUser_birth() {
        return user_birth;
    }

    public void setUser_birth(String user_birth) {
        this.user_birth = user_birth;
    }

    public String getUser_department() {
        return user_department;
    }

    public void setUser_department(String user_department) {
        this.user_department = user_department;
    }

    public String getUser_department_nm() {
        return user_department_nm;
    }

    public void setUser_department_nm(String user_department_nm) {
        this.user_department_nm = user_department_nm;
    }

    public String getHire_date() {
        return hire_date;
    }

    public void setHire_date(String hire_date) {
        this.hire_date = hire_date;
    }

    public String getUser_phone() {
        return user_phone;
    }

    public void setUser_phone(String user_phone) {
        this.user_phone = user_phone;
    }

    public String getUser_address() {
        return user_address;
    }

    public void setUser_address(String user_address) {
        this.user_address = user_address;
    }

    public String getUser_role() {
        return user_role;
    }

    public void setUser_role(String user_role) {
        this.user_role = user_role;
    }

    public String getUse_yn() {
        return use_yn;
    }

    public void setUse_yn(String use_yn) {
        this.use_yn = use_yn;
    }

    public String getEdu1_school_name() {
        if(edu1_school_name == null){
            edu1_school_name = "";
        }
        return edu1_school_name;
    }

    public void setEdu1_school_name(String edu1_school_name) {

        this.edu1_school_name = edu1_school_name;
    }

    public String getEdu1_grad_status() {
        return edu1_grad_status;
    }

    public void setEdu1_grad_status(String edu1_grad_status) {
        this.edu1_grad_status = edu1_grad_status;
    }

    public String getEdu1_start_date() {
        return edu1_start_date;
    }

    public void setEdu1_start_date(String edu1_start_date) {
        this.edu1_start_date = edu1_start_date;
    }

    public String getEdu1_end_date() {
        return edu1_end_date;
    }

    public void setEdu1_end_date(String edu1_end_date) {
        this.edu1_end_date = edu1_end_date;
    }

    public String getEdu1_gubun() {
        return edu1_gubun;
    }

    public void setEdu1_gubun(String edu1_gubun) {
        this.edu1_gubun = edu1_gubun;
    }

    public String getEdu2_school_name() {
        if(edu2_school_name == null)
            edu2_school_name = "";
        return edu2_school_name;
    }

    public void setEdu2_school_name(String edu2_school_name) {
        this.edu2_school_name = edu2_school_name;
    }

    public String getEdu2_grad_status() {
        return edu2_grad_status;
    }

    public void setEdu2_grad_status(String edu2_grad_status) {
        this.edu2_grad_status = edu2_grad_status;
    }

    public String getEdu2_start_date() {
        return edu2_start_date;
    }

    public void setEdu2_start_date(String edu2_start_date) {
        this.edu2_start_date = edu2_start_date;
    }

    public String getEdu2_end_date() {
        return edu2_end_date;
    }

    public void setEdu2_end_date(String edu2_end_date) {
        this.edu2_end_date = edu2_end_date;
    }

    public String getEdu2_gubun() {
        return edu2_gubun;
    }

    public void setEdu2_gubun(String edu2_gubun) {
        this.edu2_gubun = edu2_gubun;
    }

    public String getEdu3_school_name() {
        if(edu3_school_name == null) {
            edu3_school_name = "";
        }
        return edu3_school_name;
    }

    public void setEdu3_school_name(String edu3_school_name) {
        this.edu3_school_name = edu3_school_name;
    }

    public String getEdu3_grad_status() {
        return edu3_grad_status;
    }

    public void setEdu3_grad_status(String edu3_grad_status) {
        this.edu3_grad_status = edu3_grad_status;
    }

    public String getEdu3_start_date() {
        return edu3_start_date;
    }

    public void setEdu3_start_date(String edu3_start_date) {
        this.edu3_start_date = edu3_start_date;
    }

    public String getEdu3_end_date() {
        return edu3_end_date;
    }

    public void setEdu3_end_date(String edu3_end_date) {
        this.edu3_end_date = edu3_end_date;
    }

    public String getEdu3_gubun() {
        return edu3_gubun;
    }

    public void setEdu3_gubun(String edu3_gubun) {
        this.edu3_gubun = edu3_gubun;
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

    public int getHist_seq() {
        return hist_seq;
    }

    public void setHist_seq(int hist_seq) {
        this.hist_seq = hist_seq;
    }

    public int getFile_seq() {
        return file_seq;
    }

    public void setFile_seq(int file_seq) {
        this.file_seq = file_seq;
    }

    public String getEduGubun() {
        return eduGubun;
    }

    public void setEduGubun(String eduGubun) {
        this.eduGubun = eduGubun;
    }

    public List<ProjectVO> getProjectList() {
        return projectList;
    }

    public void setProjectList(List<ProjectVO> projectList) {
        this.projectList = projectList;
    }

    public List<QualificationVO> getQualificationList() {
        return qualificationList;
    }

    public void setQualificationList(List<QualificationVO> qualificationList) {
        this.qualificationList = qualificationList;
    }

    public List<WorkExperienceVO> getWorkExperienceList() {
        return workExperienceList;
    }

    public void setWorkExperienceList(List<WorkExperienceVO> workExperienceList) {
        this.workExperienceList = workExperienceList;
    }

    public FileVO getFileInfo() {
        return fileInfo;
    }

    public void setFileInfo(FileVO fileInfo) {
        this.fileInfo = fileInfo;
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
}
