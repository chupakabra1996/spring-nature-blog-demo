package ru.kpfu.itis.controllers;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.method.annotation.MvcUriComponentsBuilder;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import ru.kpfu.itis.exceptions.RegisterUserException;
import ru.kpfu.itis.model.entities.User;
import ru.kpfu.itis.service.UserService;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

@Controller
@RequestMapping("/registration")
public class RegistrationController {


    private static final Logger log = Logger.getLogger(RegistrationController.class);

    @Autowired
    private UserService userService;


    private MessageSourceAccessor msa;

    @Autowired
    public void setMessageSource(MessageSource messageSource){
        msa = new MessageSourceAccessor(messageSource);
    }

    @RequestMapping(method = RequestMethod.GET)
    @PreAuthorize("isAnonymous()")
    public String registration(HttpSession session, ModelMap map) {

        map.addAttribute("user", new User());
        return "registration";
    }


    @RequestMapping(method = RequestMethod.POST)
    @PreAuthorize("isAnonymous()")
    public String registerUser(
            RedirectAttributes redirectAttributes,
            @Valid @ModelAttribute("user") User user,
            BindingResult bindingResult
    ) {

        if (bindingResult.hasErrors()){
            return "registration";
        }

        try{
            userService.registerNewUserAccount(user);
        } catch (RegisterUserException e) {
            if (e.getCode() == 0)
                bindingResult.rejectValue("email", "register.email.exists", new Object[]{user.getEmail()},"");
            else
                bindingResult.rejectValue("login", "register.login.exists", new Object[]{user.getLogin()},"");
            return "registration";
        }

        redirectAttributes.addFlashAttribute("message",
                msa.getMessage("register.success.message", new Object[]{user.getName()}));

        return "redirect:" + getPathWithoutArgs(MvcUriComponentsBuilder.fromMappingName("LIC#login").build());
    }


    private String getPathWithoutArgs(String path){
        return path.substring(0, path.indexOf('?'));
    }
}
