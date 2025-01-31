package kr.co.itsmart.profileMnt.controller;

import kr.co.itsmart.profileMnt.service.CommonService;
import kr.co.itsmart.profileMnt.service.ProfileInfoService;
import kr.co.itsmart.profileMnt.vo.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
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
    private final Logger LOGGER = LoggerFactory.getLogger(this.getClass());
    private final ProfileInfoService profileInfoService;
    private final CommonService commonService;

    public ProfileInfoController(ProfileInfoService profileInfoService, CommonService commonService) {
        this.profileInfoService = profileInfoService;
        this.commonService = commonService;
    }

    @GetMapping("/list")
    public String getUsrProfileInfoList(@AuthenticationPrincipal LoginVO login,
                                        @ModelAttribute ProfileVO profile,
                                        Model model) {
        LOGGER.info("== go usersProfileInfo[사용자 프로필 목록 조회 화면] ==");

        LOGGER.info("검색조건 확인 searchType={}, searchText={}", profile.getSearchType(), profile.getSearchText());

        int defaultCurPage = 1;
        if(profile.getCurPage() == 0){
            profile.setCurPage(defaultCurPage);
        }

        int curPage = profile.getCurPage();
        LOGGER.info("curPage : {}", curPage);

        // 전체 리스트 건수
        int userProfileCnt = profileInfoService.getUsrProfileInfoCnt(profile);

        PageVO pageVO = new PageVO(userProfileCnt, curPage);
        profile.setOffset(pageVO.getStartIndex());
        profile.setLimit(pageVO.getPageSize());

        List<ProfileVO> profileList = profileInfoService.getUsrProfileInfoList(profile);

        model.addAttribute("loginUser", login.getUser_id());
        model.addAttribute("userRole", login.getAuthorities());
        model.addAttribute("info", profileList);
        model.addAttribute("cnt", userProfileCnt);
        model.addAttribute("searchType", profile.getSearchType());
        model.addAttribute("searchText", profile.getSearchText());
        model.addAttribute("page", pageVO);
        return "usersProfileInfo";
    }

    @GetMapping("/register")
    public String openRegisterUsrPop(Model model) {
        LOGGER.info("== open registerUser[사용자 추가 팝업] ==");

        Map<String, String> params = new HashMap<>();
        params.put("code_group_id", "PSIT");

        List<CommonVO> psitList = commonService.getCodeList(params);
        String code_group_id = "ORG";
        List<CommonVO> orgList = commonService.getPureCodeList(code_group_id);

        model.addAttribute("psitList", psitList);
        model.addAttribute("orgList", orgList);
        return "registerUser";
    }

    @PostMapping("/register")
    public ResponseEntity<Object> registerUserInfo(@AuthenticationPrincipal LoginVO login,
                                                   @ModelAttribute ProfileVO profile,
                                                   @RequestParam(required = false, value = "imgFile") MultipartFile file) {
        LOGGER.info("== Ajax[사용자 프로필 입력 처리] ==");
        String user_id = profile.getUser_id();

        if (file != null) {
            // CREATE file_seq
            int file_seq = commonService.getMaxHistSeq(user_id);
            LOGGER.info("파일 정보 file_seq: file_seq={}", file_seq);

            // 파일 서버 저장
            FileVO fileVO = commonService.saveImageFile(file);

            // 파일 정보 DB 저장
            fileVO.setUser_id(user_id);
            fileVO.setFile_seq(file_seq);
            fileVO.setFile_se("PROFILE");
            commonService.insertUsrFileInfo(fileVO);
        }

        // CREATE hist_seq
        int hist_seq = profileInfoService.getMaxHistSeq(user_id);
        profile.setHist_seq(hist_seq);
        LOGGER.info("프로필 정보 hist_seq: hist_seq={}", hist_seq);

        // ID중복 확인
        if (profileInfoService.checkUsrExists(user_id)) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("이미 사용중인 아이디입니다.");
        }

        // 신규 정보 입력
        profile.setCreator(login.getUser_id());
        profileInfoService.insertUsrProfile(profile);

        return ResponseEntity.ok().build();
    }
}
