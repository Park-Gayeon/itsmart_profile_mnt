package kr.co.itsmart.projectdemo.vo;

import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

@Getter
@Setter
public class CommonVO {
    private String code_group_id;
    private String code_id;
    private String code_group_nm;
    private String code_value;
    private String parent_id;
    private int level;
    private String use_yn;

    // meta_data
    private String created_date;
    private String modified_date;
    private String creator;
    private String modifier;
}
