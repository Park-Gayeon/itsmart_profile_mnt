package kr.co.itsmart.projectdemo.service;

import kr.co.itsmart.projectdemo.dao.CommonDAO;
import kr.co.itsmart.projectdemo.vo.CommonVO;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class CommonServiceImpl implements CommonService{
    private final CommonDAO commonDAO;

    public CommonServiceImpl(CommonDAO commonDAO){
        this.commonDAO = commonDAO;
    }

    @Override
    public List<CommonVO> selectCodeList(Map<String, String> params){
        return commonDAO.selectCodeList(params);
    };

    @Override
    public List<CommonVO> getTaskMidCode(String code_id) {
        return commonDAO.getTaskMidCode(code_id);
    }
}
