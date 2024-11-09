package kr.co.itsmart.projectdemo.vo;

import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

@Getter
@Setter
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

}
