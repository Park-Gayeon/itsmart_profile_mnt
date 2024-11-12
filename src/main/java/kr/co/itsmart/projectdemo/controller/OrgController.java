package kr.co.itsmart.projectdemo.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/api/main/company")
public class OrgController {
    @GetMapping("/organization")
    public String getOrganization(){
        return "organization";
    }
}
