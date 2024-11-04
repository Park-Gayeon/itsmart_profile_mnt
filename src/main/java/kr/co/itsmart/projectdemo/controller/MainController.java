package kr.co.itsmart.projectdemo.controller;

import kr.co.itsmart.projectdemo.service.SampleService;
import kr.co.itsmart.projectdemo.vo.SampleVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequiredArgsConstructor
public class MainController {
    private final SampleService sampleService;

    @GetMapping(value = "/main")
    public String selectInfo(Model model){
        SampleVO sample = sampleService.selectInfo();
        model.addAttribute("model", sample);
        return "main";
    }
}
