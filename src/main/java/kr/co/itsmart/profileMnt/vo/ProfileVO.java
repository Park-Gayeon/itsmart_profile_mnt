package kr.co.itsmart.profileMnt.vo;

import java.math.BigDecimal;
import java.util.List;

public class ProfileVO{
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

    // 이력관리
    private int hist_seq; // 이력 순번

    // etc
    private int cnt; // 건수
    private String project_nm; // 프로젝트 명
    private String project_start_date; // 프로젝트 시작일
    private String project_end_date; // 프로젝트 종료일
    private int project_totalMonth; // 수행경력
    private String project_client; // 발주처
    private String qualification_yn; // 정보처리기사 자격증 여부

    // 검색조건
    private String searchType; // 검색타입
    private String searchText; // 검색내용

    // paging
    private int curPage;
    private int offset;
    private int limit;

    private List<EduVO> educationList;
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

    public int getHist_seq() {
        return hist_seq;
    }

    public void setHist_seq(int hist_seq) {
        this.hist_seq = hist_seq;
    }

    public int getCnt() {
        return cnt;
    }

    public void setCnt(int cnt) {
        this.cnt = cnt;
    }

    public String getProject_nm() {
        return project_nm;
    }

    public void setProject_nm(String project_nm) {
        this.project_nm = project_nm;
    }

    public String getProject_start_date() {
        return project_start_date;
    }

    public void setProject_start_date(String project_start_date) {
        this.project_start_date = project_start_date;
    }

    public String getProject_end_date() {
        return project_end_date;
    }

    public void setProject_end_date(String project_end_date) {
        this.project_end_date = project_end_date;
    }

    public int getProject_totalMonth() {
        return project_totalMonth;
    }

    public void setProject_totalMonth(int project_totalMonth) {
        this.project_totalMonth = project_totalMonth;
    }

    public String getProject_client() {
        return project_client;
    }

    public void setProject_client(String project_client) {
        this.project_client = project_client;
    }

    public String getQualification_yn() {
        return qualification_yn;
    }

    public void setQualification_yn(String qualification_yn) {
        this.qualification_yn = qualification_yn;
    }

    public String getSearchType() {
        if (searchType == null)
            searchType = "";
        return searchType;
    }

    public void setSearchType(String searchType) {
        this.searchType = searchType;
    }

    public String getSearchText() {
        if(searchText == null)
            searchText = "";
        return searchText;
    }

    public void setSearchText(String searchText) {
        this.searchText = searchText;
    }

    public int getCurPage() {
        return curPage;
    }

    public void setCurPage(int curPage) {
        this.curPage = curPage;
    }

    public int getOffset() {
        return offset;
    }

    public void setOffset(int offset) {
        this.offset = offset;
    }

    public int getLimit() {
        return limit;
    }

    public void setLimit(int limit) {
        this.limit = limit;
    }

    public int getFile_seq() {
        return file_seq;
    }

    public void setFile_seq(int file_seq) {
        this.file_seq = file_seq;
    }

    public List<EduVO> getEducationList() {
        return educationList;
    }

    public void setEducationList(List<EduVO> educationList) {
        this.educationList = educationList;
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
