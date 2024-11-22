package kr.co.itsmart.profileMnt.service;

import kr.co.itsmart.profileMnt.dao.CommonDAO;
import kr.co.itsmart.profileMnt.vo.CommonVO;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class CommonServiceImpl implements CommonService {
    private final CommonDAO commonDAO;

    public CommonServiceImpl(CommonDAO commonDAO) {
        this.commonDAO = commonDAO;
    }

    @Override
    public List<CommonVO> selectCodeList(Map<String, String> params) {
        return commonDAO.selectCodeList(params);
    }

    ;

    @Override
    public List<CommonVO> getTaskMidCodeList(String code_id) {
        return commonDAO.getTaskMidCodeList(code_id);
    }
}
