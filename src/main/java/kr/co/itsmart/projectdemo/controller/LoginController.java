package kr.co.itsmart.projectdemo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/api")
public class LoginController {
    @GetMapping("/login")
    public String login(){
        // TODO : 로그인 로직
        return "login";
    }

    @GetMapping("/logout")
    public String logout(){
        // TODO : 로그아웃 로직
        return "logout";
    }
}
