package kr.co.itsmart.projectdemo.controller;

import kr.co.itsmart.projectdemo.service.ProfileService;
import kr.co.itsmart.projectdemo.vo.ProfileVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/api/profile")
@RequiredArgsConstructor
public class ProfileController {
    private final ProfileService profileService;
    @GetMapping("/detail")
    public String selectDetailInfo(Model model){
        ProfileVO profile = profileService.selectDetailInfo();
        model.addAttribute("profile", profile);
        return "selectProfileDetail";
    }
}
