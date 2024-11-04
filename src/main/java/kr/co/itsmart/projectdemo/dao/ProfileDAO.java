package kr.co.itsmart.projectdemo.dao;

import kr.co.itsmart.projectdemo.vo.ProfileVO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ProfileDAO {
    ProfileVO selectDetailInfo();
}
