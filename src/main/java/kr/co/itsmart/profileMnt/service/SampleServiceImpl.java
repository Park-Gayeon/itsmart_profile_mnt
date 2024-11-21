package kr.co.itsmart.profileMnt.service;

import kr.co.itsmart.profileMnt.dao.SampleDAO;
import kr.co.itsmart.profileMnt.vo.SampleVO;
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
