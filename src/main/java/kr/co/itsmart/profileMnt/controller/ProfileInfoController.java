package kr.co.itsmart.profileMnt.controller;

import kr.co.itsmart.profileMnt.service.CommonService;
import kr.co.itsmart.profileMnt.service.ProfileInfoService;
import kr.co.itsmart.profileMnt.vo.CommonVO;
import kr.co.itsmart.profileMnt.vo.ProfileVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/profile/info")
public class ProfileInfoController {
    private static final Logger LOGGER = LoggerFactory.getLogger(ProfileInfoController.class);
    private final ProfileInfoService profileInfoService;
    private final CommonService commonService;
    public ProfileInfoController(ProfileInfoService profileInfoService, CommonService commonService) {
        this.profileInfoService = profileInfoService;
        this.commonService = commonService;
    }

    @GetMapping("/list")
    public String getUsrProfileInfoList(Model model){
        LOGGER.info("== go usersProfileInfo[사용자 프로필 목록 조회 화면] ==");
        ProfileVO tmp = new ProfileVO();
        List<ProfileVO> profile = profileInfoService.getUsrProfileInfoList(tmp);
        for (ProfileVO list : profile) {
            System.out.println("사용자 이름: " + list.getUser_nm());
            System.out.println("부서: " + list.getUser_department_nm());
            System.out.println("프로젝트 이름: " + list.getProject_nm());
            System.out.println("클라이언트: " + list.getProject_client());
        }

        model.addAttribute("info", profile);
        return "usersProfileInfo";
    }

    @GetMapping("/register")
    public String openRegisterUsrPop(Model model){
        LOGGER.info("== open registerUser[사용자 추가 팝업] ==");

        Map<String, String> params = new HashMap<>();
        params.put("code_group_id", "ORG");
        List<CommonVO> orgList = commonService.selectCodeList(params);
        params.put("code_group_id", "PSIT");
        List<CommonVO> psitList = commonService.selectCodeList(params);

        model.addAttribute("orgList", orgList);
        model.addAttribute("psitList", psitList);
        return "registerUser";
    }

    @PostMapping("/register")
    @ResponseBody
    public String registerUserInfo(@ModelAttribute ProfileVO profile){
        LOGGER.info("== Ajax[사용자 프로필 입력 처리] ==");
        try {
            String user_id = profile.getUser_id();

            // CREATE hist_seq
            int hist_seq = profileInfoService.selectMaxHistSeq(user_id);
            profile.setHist_seq(hist_seq);
            LOGGER.info("프로필 정보 hist_seq: hist_seq={}", hist_seq);

            // ID중복 확인
            if(profileInfoService.checkUsrExists(user_id)){
                return "아이디가 중복되었습니다";
            }

            // PASSWORD 암호화 로직 적용
            profile.setUser_pw("itsmart1!");

            // 신규 정보 입력
            profileInfoService.insertUsrProfile(profile);

        } catch (Exception e){
            LOGGER.debug("프로필 입력 실패: user_id={}", profile.getUser_id(), e.getMessage());
            return "FAIL";
        }
        return "SUCCESS";
    }
}
