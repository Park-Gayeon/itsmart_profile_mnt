package kr.co.itsmart.projectdemo.dao;

import kr.co.itsmart.projectdemo.vo.SampleVO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SampleDAO{
    SampleVO selectInfo();
}

