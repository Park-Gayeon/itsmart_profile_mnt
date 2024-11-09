package kr.co.itsmart.projectdemo.dao;

import kr.co.itsmart.projectdemo.vo.ProfileVO;
import kr.co.itsmart.projectdemo.vo.ProjectVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ProfileDAO {
    /*직원(관리자 포함) : 프로필 상세화면 조회*/
    // TODO : 나중에 저 @Param의 필요성에 대해 다시한번 test
    ProfileVO selectDetailInfo(@Param("user_id") String user_id);

    /*직원(관리자 포함) : 프로필 상세화면 > 프로젝트 기술 조회*/
    ProjectVO selectUsrSkillList(ProjectVO tmpVO);

    /*관리자 : 직원 프로필 등록*/
    void registUsrProfile(ProfileVO profileVO);

    /*관리자 : 직원 목록 조회*/
    List<ProfileVO> selectUsrProfileInfo(ProfileVO profileVO);

    /*직원 : 프로필 수정*/
    void updateDetailInfo(ProfileVO profileVO);

    /*이력 등록*/
    void registUsrProfileHist(ProfileVO profileVO);

}
