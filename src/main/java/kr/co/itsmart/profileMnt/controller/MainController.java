package kr.co.itsmart.profileMnt.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {

    @GetMapping(value = "/home")
    public String main(Model model){

    model.addAttribute("key", "gypark");
    return "main";
    }
}
