package kr.co.itsmart.profileMnt.vo;


public class CommonVO {
    private String code_group_id;
    private String code_id;
    private String code_group_nm;
    private String code_value;
    private String parent_id;
    private int level;
    private String use_yn;

    // etc
    private String hierarchy_value;
    private String full_path;

    // meta_data
    private String created_date;
    private String modified_date;
    private String creator;
    private String modifier;


    public String getCode_group_id() {
        return code_group_id;
    }

    public void setCode_group_id(String code_group_id) {
        this.code_group_id = code_group_id;
    }

    public String getCode_id() {
        return code_id;
    }

    public void setCode_id(String code_id) {
        this.code_id = code_id;
    }

    public String getCode_group_nm(){
        return code_group_nm;
    }

    public void setCode_group_nm(String code_group_nm) {
        this.code_group_nm = code_group_nm;
    }

    public String getCode_value() {
        return code_value;
    }

    public void setCode_value(String code_value) {
        this.code_value = code_value;
    }

    public String getParent_id() {
        return parent_id;
    }

    public void setParent_id(String parent_id) {
        this.parent_id = parent_id;
    }

    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }

    public String getUse_yn() {
        return use_yn;
    }

    public void setUse_yn(String use_yn) {
        this.use_yn = use_yn;
    }

    public String getHierarchy_value() {
        return hierarchy_value;
    }

    public void setHierarchy_value(String hierarchy_value) {
        this.hierarchy_value = hierarchy_value;
    }

    public String getFull_path() {
        return full_path;
    }

    public void setFull_path(String full_path) {
        this.full_path = full_path;
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
