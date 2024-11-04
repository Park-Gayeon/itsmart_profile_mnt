package kr.co.itsmart.projectdemo.service;

import kr.co.itsmart.projectdemo.dao.SampleDAO;
import kr.co.itsmart.projectdemo.vo.SampleVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class SampleServiceImpl implements SampleService{
    private final SampleDAO sampleDAO;

    @Override
    public SampleVO selectInfo(){
        return sampleDAO.selectInfo();
    }
}
