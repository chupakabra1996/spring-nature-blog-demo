package ru.kpfu.itis.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.access.AccessDeniedHandlerImpl;
import org.springframework.security.web.csrf.CsrfFilter;
import org.springframework.security.web.csrf.InvalidCsrfTokenException;
import org.springframework.security.web.csrf.MissingCsrfTokenException;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.web.filter.CharacterEncodingFilter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    private UserDetailsService userDetailsService;

    @Autowired
    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsService).passwordEncoder(passwordEncoder());
    }


    @Override
    protected void configure(HttpSecurity http) throws Exception {

        http.addFilterBefore(characterEncodingFilter(), CsrfFilter.class);
        http.
            authorizeRequests()
                .anyRequest().permitAll()
            .and()
            .formLogin()
                .loginPage("/login")
                .defaultSuccessUrl("/")
                .passwordParameter("password").usernameParameter("login")
                .failureUrl("/login?error")
            .and()
            .logout()
                .logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
                .logoutSuccessUrl("/login?logout")
                .deleteCookies("remember-me")
            .and()
            .rememberMe()
                .key("remember-me")
                .tokenValiditySeconds(60*60*72)
            .and()
            .csrf()
                .requireCsrfProtectionMatcher(new AntPathRequestMatcher("/**","POST",false))
                .ignoringAntMatchers("/post/save/**")
            .and()
                .exceptionHandling().accessDeniedHandler(new CustomAccessDeniedHandler());
    }


    @Bean
    public PasswordEncoder passwordEncoder(){
        return new BCryptPasswordEncoder();
    }



    public class CustomAccessDeniedHandler extends AccessDeniedHandlerImpl {
        @Override
        public void handle(HttpServletRequest request, HttpServletResponse response, AccessDeniedException accessDeniedException)
                throws IOException, ServletException {

            if(accessDeniedException instanceof MissingCsrfTokenException
                    || accessDeniedException instanceof InvalidCsrfTokenException) {
                if(request.getRequestURI().contains("login")){
                    response.sendRedirect(request.getContextPath()+"/login?error=token");
                }
            }

            super.handle(request, response, accessDeniedException);
        }
    }

    @Bean
    public CharacterEncodingFilter characterEncodingFilter() {
        CharacterEncodingFilter filter = new CharacterEncodingFilter();
        filter.setEncoding("UTF-8");
        filter.setForceEncoding(true);
        return filter;
    }

}
