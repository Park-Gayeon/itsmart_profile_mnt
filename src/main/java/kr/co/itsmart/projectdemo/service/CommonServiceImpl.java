package kr.co.itsmart.projectdemo.service;

import kr.co.itsmart.projectdemo.dao.CommonDAO;
import kr.co.itsmart.projectdemo.vo.CommonVO;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommonServiceImpl implements CommonService{
    private final CommonDAO commonDAO;

    public CommonServiceImpl(CommonDAO commonDAO){
        this.commonDAO = commonDAO;
    }

    @Override
    public int maxHistSeq(String user_id){
        return commonDAO.maxHistSeq(user_id);
    }

    @Override
    public List<CommonVO> selectCodeList(String code_group_id){
        return commonDAO.selectCodeList(code_group_id);
    };

}
