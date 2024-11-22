package kr.co.itsmart.profileMnt.service;

import kr.co.itsmart.profileMnt.dao.ProfileDAO;
import kr.co.itsmart.profileMnt.vo.ProfileVO;
import org.springframework.stereotype.Service;

@Service
public class ProfileDetailServiceImpl implements ProfileDetailService {
    private final ProfileDAO profileDAO;

    public ProfileDetailServiceImpl(ProfileDAO profileDAO) {
        this.profileDAO = profileDAO;
    }

    @Override
    public ProfileVO selectUsrProfileDetail(String user_id) {
        return profileDAO.selectUsrProfileDetail(user_id);
    }

}
