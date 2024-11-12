package kr.co.itsmart.projectdemo.vo;

import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

public class FileVO {
    private String user_id;
    private int file_seq;
    private String file_ori_nm;
    private String file_sver_nm;
    private String file_sver_path;
    private String file_extension;
    private String use_yn;

    // meta_data
    private String created_date;
    private String creator;


    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public int getFile_seq() {
        return file_seq;
    }

    public void setFile_seq(int file_seq) {
        this.file_seq = file_seq;
    }

    public String getFile_ori_nm() {
        return file_ori_nm;
    }

    public void setFile_ori_nm(String file_ori_nm) {
        this.file_ori_nm = file_ori_nm;
    }

    public String getFile_sver_nm() {
        return file_sver_nm;
    }

    public void setFile_sver_nm(String file_sver_nm) {
        this.file_sver_nm = file_sver_nm;
    }

    public String getFile_sver_path() {
        return file_sver_path;
    }

    public void setFile_sver_path(String file_sver_path) {
        this.file_sver_path = file_sver_path;
    }

    public String getFile_extension() {
        return file_extension;
    }

    public void setFile_extension(String file_extension) {
        this.file_extension = file_extension;
    }

    public String getUse_yn() {
        return use_yn;
    }

    public void setUse_yn(String use_yn) {
        this.use_yn = use_yn;
    }

    public String getCreated_date() {
        return created_date;
    }

    public void setCreated_date(String created_date) {
        this.created_date = created_date;
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator;
    }

}
