package kr.co.itsmart.profileMnt.controller;

import kr.co.itsmart.profileMnt.vo.LoginVO;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {
    @GetMapping(value = "/home")
    public String main(@AuthenticationPrincipal LoginVO login, Model model){

        model.addAttribute("loginUser", login.getUsername());
        model.addAttribute("userRole", login.getAuthorities());
        return "main";
    }
}
