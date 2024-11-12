package kr.co.itsmart.projectdemo.controller;

import kr.co.itsmart.projectdemo.service.SampleService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {
    private final SampleService sampleService;

    public MainController(SampleService sampleService) {
        this.sampleService = sampleService;
    }

    @GetMapping(value = "/main")
    public String selectInfo(Model model){
        /*SampleVO sample = sampleService.selectInfo();*/
        model.addAttribute("key", "gypark");
        return "main";
    }
}
