package kr.co.itsmart.profileMnt.configuration;

import org.springframework.beans.propertyeditors.CustomNumberEditor;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.InitBinder;

@ControllerAdvice
public class UtilConfig {
    @InitBinder
    public void initBinder(WebDataBinder binder){
        binder.registerCustomEditor(int.class, new CustomNumberEditor(Integer.class, false));
    }
}
