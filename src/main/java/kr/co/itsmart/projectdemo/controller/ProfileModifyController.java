package kr.co.itsmart.projectdemo.controller;

import kr.co.itsmart.projectdemo.service.CommonService;
import kr.co.itsmart.projectdemo.service.ProfileModifyService;
import kr.co.itsmart.projectdemo.vo.CommonVO;
import kr.co.itsmart.projectdemo.vo.ProfileVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/profile/modify")
public class ProfileModifyController {
    private final ProfileModifyService profileModifyService;
    private final CommonService commonService;

    public ProfileModifyController(ProfileModifyService profileModifyService, CommonService commonService) {
        this.profileModifyService = profileModifyService;
        this.commonService = commonService;
    }


    @PostMapping("/{user_id}")
    public String modifyUsrProfile(@ModelAttribute ProfileVO profile, Model model) {
        List<CommonVO> orgList = commonService.selectCodeList("ORG");
        List<CommonVO> psitList = commonService.selectCodeList("PSIT");
        List<CommonVO> roleList = commonService.selectCodeList("ROLE");
        List<CommonVO> taskLarList = commonService.selectCodeList("TASK");
        List<CommonVO> taskMidLIst = commonService.selectCodeList("TASK");

        model.addAttribute("profile", profile);
        model.addAttribute("orgList", orgList);
        model.addAttribute("psitList", psitList);
        model.addAttribute("roleList", roleList);
        model.addAttribute("taskLarList", taskLarList);
        model.addAttribute("taskMidLIst", taskMidLIst);

        return "selectProfileModify";
    }

    @PostMapping("/update/{user_id}")
    @ResponseBody // ajax 요청에 json이나 문자열을 반환하도록 지정한다
    public String updateUsrProfile(@PathVariable("user_id") String user_id, @ModelAttribute ProfileVO profile) {
        System.out.println("============================");
        for (int i = 0; i < profile.getQualificationList().size(); i++) {
            System.out.println(profile.getQualificationList().get(i).getQualification_seq());
            System.out.println(profile.getQualificationList().get(i).getQualification_nm());
        }

        System.out.println("============================");
        for(int i = 0; i < profile.getProjectList().size(); i++){
            System.out.println(profile.getProjectList().get(i).getProject_nm());
            System.out.println(profile.getProjectList().get(i).getProject_start_date());
            System.out.println(profile.getProjectList().get(i).getProject_end_date());
        }

        // 0. hist_seq 생성
        int hist_seq = commonService.maxHistSeq(user_id);
        profile.setHist_seq(hist_seq);

        // 1. 프로필 이미지 사진 추가 및 변경된 경우 INSERT 작업


        // 2. 프로필 상세 정보 UPDATE/INSERT(HIST) 작업
        System.out.println("2. 프로필 상세 정보 UPDATE/INSERT(HIST) 작업");
        boolean rst = profileModifyService.updateUsrProfileInfo(profile);
        System.out.println("2. 프로필 상세 정보 UPDATE/INSERT(HIST) 작업 끝");
        if (rst) {
            // 3. 프로필 관련 테이블 /DELETE/UPDATE(=INSERT) 작업
            System.out.println("3. 프로필 관련 테이블 작업");
            profileModifyService.updateUsrProject(profile);
            profileModifyService.updateUsrQualification(profile);
            profileModifyService.updateUsrWorkExperience(profile);
            System.out.println("3. 프로필 관련 테이블 작업 끝");


        } else {
            return "false";
        }
        return "success";

        // 저장 성공 여부에 따라 메시지 반환

        // 5. SKILL 에 대한 정보 UPDATE/INSERT(HIST) 작업 ==> 별도 로직 으로 구현 예정


    }

}

