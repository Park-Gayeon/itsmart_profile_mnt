package kr.co.itsmart.profileMnt;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;

@SpringBootApplication(exclude = SecurityAutoConfiguration.class)
// Spring Boot Security Auto Configuration 비활성화
public class ProjectDemoApplication {

    public static void main(String[] args) {
        SpringApplication.run(ProjectDemoApplication.class, args);
    }

}
