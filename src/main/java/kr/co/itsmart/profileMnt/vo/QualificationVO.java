package kr.co.itsmart.profileMnt.vo;

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

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public int getQualification_seq() {
        return qualification_seq;
    }

    public void setQualification_seq(int qualification_seq) {
        this.qualification_seq = qualification_seq;
    }

    public String getQualification_nm() {
        return qualification_nm;
    }

    public void setQualification_nm(String qualification_nm) {
        this.qualification_nm = qualification_nm;
    }

    public String getIssuer() {
        return issuer;
    }

    public void setIssuer(String issuer) {
        this.issuer = issuer;
    }

    public String getAcquisition_date() {
        return acquisition_date;
    }

    public void setAcquisition_date(String acquisition_date) {
        this.acquisition_date = acquisition_date;
    }

    public String getExpiry_date() {
        return expiry_date;
    }

    public void setExpiry_date(String expiry_date) {
        this.expiry_date = expiry_date;
    }

    public String getIs_expired() {
        return is_expired;
    }

    public void setIs_expired(String is_expired) {
        this.is_expired = is_expired;
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
