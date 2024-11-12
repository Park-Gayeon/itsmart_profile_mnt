package kr.co.itsmart.projectdemo.vo;

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

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public int getWork_seq() {
        return work_seq;
    }

    public void setWork_seq(int work_seq) {
        this.work_seq = work_seq;
    }

    public String getWork_place() {
        return work_place;
    }

    public void setWork_place(String work_place) {
        this.work_place = work_place;
    }

    public String getWork_start_date() {
        return work_start_date;
    }

    public void setWork_start_date(String work_start_date) {
        this.work_start_date = work_start_date;
    }

    public String getWork_end_date() {
        return work_end_date;
    }

    public void setWork_end_date(String work_end_date) {
        this.work_end_date = work_end_date;
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
