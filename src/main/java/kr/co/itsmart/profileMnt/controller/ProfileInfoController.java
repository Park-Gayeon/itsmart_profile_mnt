package kr.co.itsmart.profileMnt.controller;

import kr.co.itsmart.profileMnt.service.CommonService;
import kr.co.itsmart.profileMnt.service.ProfileInfoService;
import kr.co.itsmart.profileMnt.vo.CommonVO;
import kr.co.itsmart.profileMnt.vo.FileVO;
import kr.co.itsmart.profileMnt.vo.ProfileVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

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
    public String getUsrProfileInfoList(@ModelAttribute ProfileVO profile, Model model) {
        LOGGER.info("== go usersProfileInfo[사용자 프로필 목록 조회 화면] ==");

        LOGGER.info("검색조건 확인 searchType={}, searchText={}", profile.getSearchType(), profile.getSearchText());
        List<ProfileVO> profileList = profileInfoService.getUsrProfileInfoList(profile);

        int userProfileCnt = profileInfoService.getUsrProfileInfoCnt(profile);

        model.addAttribute("info", profileList);
        model.addAttribute("cnt", userProfileCnt);
        model.addAttribute("searchType", profile.getSearchType());
        model.addAttribute("searchText", profile.getSearchText());
        return "usersProfileInfo";
    }

    @GetMapping("/register")
    public String openRegisterUsrPop(Model model) {
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
    public ResponseEntity<String> registerUserInfo(@ModelAttribute ProfileVO profile,
                                                   @RequestParam(required = false, value = "imgFile") MultipartFile file) {
        LOGGER.info("== Ajax[사용자 프로필 입력 처리] ==");
        try {
            String user_id = profile.getUser_id();

            if (file != null) {
                // CREATE file_seq
                int file_seq = commonService.selectMaxHistSeq(user_id);
                LOGGER.info("파일 정보 file_seq: file_seq={}", file_seq);

                // 파일 서버 저장
                FileVO fileVO = commonService.saveImageFile(file);

                // 파일 정보 DB 저장
                fileVO.setUser_id(user_id);
                fileVO.setFile_seq(file_seq);
                commonService.insertUsrFileInfo(fileVO);
            }

            // CREATE hist_seq
            int hist_seq = profileInfoService.selectMaxHistSeq(user_id);
            profile.setHist_seq(hist_seq);
            LOGGER.info("프로필 정보 hist_seq: hist_seq={}", hist_seq);

            // ID중복 확인
            if (profileInfoService.checkUsrExists(user_id)) {
                return ResponseEntity.badRequest().body("아이디가 중복됩니다.");
            }

            // 신규 정보 입력
            profileInfoService.insertUsrProfile(profile);

            return ResponseEntity.ok("SUCCESS");

        } catch (Exception e) {
            LOGGER.debug("프로필 입력 실패: user_id={}", profile.getUser_id(), e.getMessage());
            return ResponseEntity.internalServerError().body("프로필 정보 처리에 실패했습니다." + e.getMessage());
        }
    }
}
