package kr.co.itsmart.profileMnt.dao;

import kr.co.itsmart.profileMnt.vo.SampleVO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SampleDAO{
    SampleVO selectInfo();
}

