package kr.co.itsmart.projectdemo.vo;

import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

import java.util.List;

@Getter
@Setter
public class ProjectVO {
    private String user_id; // 직원 아이디
    private int project_seq; // 사업 순번
    private String project_nm; // 사업명
    private String project_start_date; // 투입시작일
    private String project_end_date; // 투입종료일
    private String project_role; // 역할
    private String project_client; // 발주처
    private String assigned_task_lar; // 담당업무(대분류)
    private String assigned_task_mid; // 담당업무(소분류)
    private String assigned_task_lar_nm; // 담당업무(대분류)
    private String assigned_task_mid_nm; // 담당업무(소분류)
    private String user_yn; // 사용여부

    // 이력관리
    private int hist_seq; // 이력 순번

    // etc (검색 조건 변수 추가 예정)

    private List<UserSkillVO> skillList;

    // meta_data
    private String create_date; // 생성일시
    private String modified_date; // 수정일시
    private String creator; // 생성자
    private String modifier; // 수정자
}
