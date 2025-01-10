package kr.co.itsmart.profileMnt.dao;

import kr.co.itsmart.profileMnt.vo.ProfileVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ScheduleDAO {

    /* 일정관리 화면 건수 조회 */
    int getListCnt(ProfileVO profile);

    /* 일정관리 화면 리스트 조회 */
    List<ProfileVO> getProjectList(ProfileVO profile);

    /* 투입인력에 관한 정보 조회 */
    List<ProfileVO> getUsersInfoList(String project_nm);


}
