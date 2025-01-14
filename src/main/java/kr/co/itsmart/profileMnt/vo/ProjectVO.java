package kr.co.itsmart.profileMnt.vo;

import java.util.List;

public class ProjectVO {
    private String user_id; // 직원 아이디
    private int project_seq; // 사업 순번
    private String project_nm; // 사업명
    private String project_start_date; // 투입시작일
    private String project_end_date; // 투입종료일
    private String project_role; // 역할 코드
    private String project_role_nm; // 역할명
    private String project_client; // 발주처
    private String assigned_task_lar; // 담당업무(대분류)
    private String assigned_task_mid; // 담당업무(소분류)
    private String assigned_task_lar_nm; // 담당업무(대분류)
    private String assigned_task_mid_nm; // 담당업무(소분류)
    private String use_yn; // 사용여부
    private String master_id; // 마스터 아이디

    // 이력관리
    private int hist_seq; // 이력 순번

    // 검색조건
    private String searchType; // 검색타입
    private String searchText; // 검색내용

    // etc
    private int totalMonth; // 총 사업 경력
    private int cnt; // 건수

    // paging
    private int curPage;
    private int offset;
    private int limit;


    private List<UserSkillVO> skillList;

    // meta_data
    private String create_date; // 생성일시
    private String modified_date; // 수정일시
    private String creator; // 생성자
    private String modifier; // 수정자

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public int getProject_seq() {
        return project_seq;
    }

    public void setProject_seq(int project_seq) {
        this.project_seq = project_seq;
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

    public String getProject_role() {
        return project_role;
    }

    public void setProject_role(String project_role) {
        this.project_role = project_role;
    }

    public String getProject_role_nm() {
        return project_role_nm;
    }

    public void setProject_role_nm(String project_role_nm) {
        this.project_role_nm = project_role_nm;
    }

    public String getProject_client() {
        return project_client;
    }

    public void setProject_client(String project_client) {
        this.project_client = project_client;
    }

    public String getAssigned_task_lar() {
        return assigned_task_lar;
    }

    public void setAssigned_task_lar(String assigned_task_lar) {
        this.assigned_task_lar = assigned_task_lar;
    }

    public String getAssigned_task_mid() {
        return assigned_task_mid;
    }

    public void setAssigned_task_mid(String assigned_task_mid) {
        this.assigned_task_mid = assigned_task_mid;
    }

    public String getAssigned_task_lar_nm() {
        return assigned_task_lar_nm;
    }

    public void setAssigned_task_lar_nm(String assigned_task_lar_nm) {
        this.assigned_task_lar_nm = assigned_task_lar_nm;
    }

    public String getAssigned_task_mid_nm() {
        return assigned_task_mid_nm;
    }

    public void setAssigned_task_mid_nm(String assigned_task_mid_nm) {
        this.assigned_task_mid_nm = assigned_task_mid_nm;
    }

    public String getUse_yn() {
        if (use_yn == null) {
            use_yn = "Y";
        }
        return use_yn;
    }

    public String getMaster_id() {
        if (master_id == null) master_id = "";
        return master_id;
    }

    public void setMaster_id(String master_id) {
        this.master_id = master_id;
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

    public int getTotalMonth() {
        return totalMonth;
    }

    public void setTotalMonth(int totalMonth) {
        this.totalMonth = totalMonth;
    }

    public int getCnt() {
        return cnt;
    }

    public void setCnt(int cnt) {
        this.cnt = cnt;
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

    public List<UserSkillVO> getSkillList() {
        return skillList;
    }

    public void setSkillList(List<UserSkillVO> skillList) {
        this.skillList = skillList;
    }

    public String getCreate_date() {
        return create_date;
    }

    public void setCreate_date(String create_date) {
        this.create_date = create_date;
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
