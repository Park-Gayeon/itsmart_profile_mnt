package kr.co.itsmart.projectdemo.vo;

import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

@Getter
@Setter
public class UserSkillVO {
    private String user_id; // 직원 아이디
    private int project_seq; // 사업 순번
    private int skill_id; // 기술 아이디
    private String skill_nm; // 기술명
    private String use_yn; // 사용여부
    
    // 이력 관리
    private int hist_seq; // 이력 순번

    // meta_data
    private String created_date; // 생성일시
    private String modified_date; // 수정일시
    private String creator; // 생성자
    private String modifier; // 수정자
}
