package kr.co.itsmart.projectdemo.service;

import kr.co.itsmart.projectdemo.dao.SampleDAO;
import kr.co.itsmart.projectdemo.vo.SampleVO;
import org.springframework.stereotype.Service;

@Service
public class SampleServiceImpl implements SampleService{
    private final SampleDAO sampleDAO;

    public SampleServiceImpl(SampleDAO sampleDAO) {
        this.sampleDAO = sampleDAO;
    }

    @Override
    public SampleVO selectInfo(){
        return sampleDAO.selectInfo();
    }
}
