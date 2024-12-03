package kr.co.itsmart.profileMnt.configuration;

import org.springframework.boot.autoconfigure.security.servlet.PathRequest;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {
    private final JwtAuthenticationEntryPoint jwtAuthenticationEntryPoint;
    private AuthenticationProvider authenticationProvider;

    public SecurityConfig(JwtAuthenticationEntryPoint jwtAuthenticationEntryPoint
            , AuthenticationProvider authenticationProvider
    ) {
        this.jwtAuthenticationEntryPoint = jwtAuthenticationEntryPoint;
        this.authenticationProvider = authenticationProvider;
    }

    /*
     * CSRF(Cross Site Request Forgery) 공격 방지 활성화
     * [CsrfTokenRepository, CsrfTokenRequestHandler, AccessDeniedHandler, RequestMatcher]
     * CSRF 방지 프로세스
     * 1. CSRF 필터는 CsrfTokenRepository 에 토큰 요청 > DeferredCsrfToken 을 받아옴(성능 개선을 위해 지연 로딩 사용)
     * 2. CsrfTokenRequestHandler에서 받아온 CsrfToken을 전달하여 애플리케이션의 다른 부분에서 사용가능하도록 요청 속성에 추가
     * 3. RequestMatcher와 비교해서 CSRF 방지 대상이 아니면, 다음 필터로 넘어가고 대상이면 CSRF 방지 절차를 시작
     * 4. 지연되었던 DeferredCsrfToken에 CsrfToken이 완전히 로드되고, CsrfTokenRequestHandler를 사용해서 클라이언트가 제공한 실제 CsrfToken을 찾는다
     * 5. 실제 CsfrToken이 저장될 CsrfToken와 같으면 절차가 종료. 실패 시 AccessDeniedException이 발생하고 AccessDeniedHandler가 처리
     * https://blog.dgmoonlabs.com/268 */
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .csrf(csrf -> csrf.disable()) // CSRF 보호 비활성화(임시)
                .authorizeHttpRequests(auth -> auth
                        .requestMatchers("/auth/**").permitAll() // 모든 요청허용(임시)
                        .anyRequest().authenticated()
                )
                .formLogin(login -> login.disable()) // 기본 로그인 폼 비활성화
                .authenticationProvider(authenticationProvider);
        return http.build();
    }

    @Bean
    public WebSecurityCustomizer webSecurityCustomizer() {
        return (web) -> web.ignoring()
                .requestMatchers(PathRequest.toStaticResources().atCommonLocations())
                .requestMatchers("/WEB-INF/views/**");
    }
}
