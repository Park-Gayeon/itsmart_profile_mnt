package kr.co.itsmart.profileMnt.configuration;

import kr.co.itsmart.profileMnt.service.ProfileInfoService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
public class ApplicationConfig {

    private final Logger logger = LoggerFactory.getLogger(this.getClass());
    private final ProfileInfoService profileInfoService;

    public ApplicationConfig(@Lazy ProfileInfoService profileInfoService) {
        this.profileInfoService = profileInfoService;
    }

    @Bean
    public PasswordEncoder passwordEncoder(){
        return new BCryptPasswordEncoder();
    }


    @Bean
    public UserDetailsService userDetailsService() {
        return username -> {
            return profileInfoService.getUsrInfo(username)
                    .orElseThrow(() -> {
                        logger.warn("사용자를 찾을 수 없습니다: {}", username);
                        return new UsernameNotFoundException("사용자를 찾을 수 없습니다. ID: " + username);
                    });
        };
    }

    @Bean
    public AuthenticationProvider authenticationProvider(){
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        authProvider.setUserDetailsService(userDetailsService());
        authProvider.setPasswordEncoder(passwordEncoder());
        return authProvider;
    }


    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration config)
            throws Exception {
        return config.getAuthenticationManager();
    }
}
