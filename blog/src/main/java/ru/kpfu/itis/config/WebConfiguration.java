package ru.kpfu.itis.config;

import freemarker.template.utility.XmlEscape;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.data.web.config.EnableSpringDataWebSupport;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.validation.Validator;
import org.springframework.validation.beanvalidation.LocalValidatorFactoryBean;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.i18n.CookieLocaleResolver;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;
import org.springframework.web.servlet.view.freemarker.FreeMarkerViewResolver;
import ru.kpfu.itis.service.UserDetailServiceImpl;
import ru.kpfu.itis.service.aspects.LoggingAspect;
import ru.kpfu.itis.utils.MvcURIBuilder;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

@Configuration
@ComponentScan(basePackages = {"ru.kpfu.itis.controllers","ru.kpfu.itis.utils"})
@EnableWebMvc
@EnableSpringDataWebSupport
@EnableAspectJAutoProxy
public class WebConfiguration extends WebMvcConfigurerAdapter {



    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/assets/**").addResourceLocations("/assets/");
        registry.addResourceHandler("/assets/css/**").addResourceLocations("/assets/css/");
        registry.addResourceHandler("/assets/js/**").addResourceLocations("/assets/js/");
        registry.addResourceHandler("/assets/images/**").addResourceLocations("/assets/images/");
        registry.addResourceHandler("/assets/revslider-demo/**").addResourceLocations("/assets/revslider-demo/");
    }


    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addViewController("/").setViewName("index");
        registry.addViewController("/about").setViewName("about");
        registry.addViewController("/contacts").setViewName("contacts");
        registry.addViewController("/gallery").setViewName("gallery");
    }


    //beans

    @Bean
    public ViewResolver viewResolver() {
        FreeMarkerViewResolver resolver = new FreeMarkerViewResolver();
        resolver.setCache(true);
        resolver.setPrefix("");
        resolver.setSuffix(".ftl");
        resolver.setContentType("text/html; charset=UTF-8");
        return resolver;
    }

    @Bean
    public FreeMarkerConfigurer freemarkerConfig() {
        FreeMarkerConfigurer configurer = new FreeMarkerConfigurer();
        configurer.setTemplateLoaderPath("/WEB-INF/views/ftl/");
        configurer.setDefaultEncoding("UTF-8");
        Map<String, Object> map = new HashMap<>();
        map.put("xml_escape", new XmlEscape());
        map.put("mvcUri", new MvcURIBuilder());
        configurer.setFreemarkerVariables(map);

        return configurer;
    }


    @Bean
    public MessageSource messageSource() {
        ReloadableResourceBundleMessageSource res = new ReloadableResourceBundleMessageSource();
        res.setBasenames("classpath:i18n/message", "classpath:i18n/validation");
        res.setCacheSeconds(0);
        res.setDefaultEncoding("UTF-8");
        res.setUseCodeAsDefaultMessage(false);
        return res;
    }


    @Bean
    public LocaleResolver localeResolver() {
        CookieLocaleResolver localeResolver = new CookieLocaleResolver();
        localeResolver.setCookieName("lang");
        localeResolver.setCookieMaxAge(Integer.MAX_VALUE);
        localeResolver.setCookieDomain("/");
        localeResolver.setDefaultLocale(new Locale("ru", "RU"));
        return localeResolver;
    }


    @Bean
    public MultipartResolver multipartResolver(){
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver();
        multipartResolver.setMaxUploadSizePerFile(10242880);
        multipartResolver.setDefaultEncoding("UTF-8");
        return multipartResolver;
    }

    @Bean
    public LoggingAspect loggingAspect(){
        return new LoggingAspect();
    }


    @Bean
    public Validator validator(){
        return new LocalValidatorFactoryBean();
    }


    @Bean
    public UserDetailsService userDetailsService(){
        return new UserDetailServiceImpl();
    }

}
