package ru.kpfu.itis.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import ru.kpfu.itis.model.entities.User;
import ru.kpfu.itis.service.UserService;

import java.security.Principal;

@Controller
@RequestMapping(value = "/user")
public class UserController {

    @Autowired
    private UserService userService;

    private MessageSourceAccessor msa;

    @Autowired
    public void setMsa(MessageSource messageSource){
        msa = new MessageSourceAccessor(messageSource);
    }


    @RequestMapping(method = RequestMethod.GET, value = "/profile/{id}")
    public String showGuestProfile(@PathVariable("id") int id, ModelMap map){

        User user = userService.findUserById(id);

        map.addAttribute("user", user);

        return "user_profile";
    }



    @PreAuthorize("isAuthenticated()")
    @RequestMapping(method = RequestMethod.GET, value = "/profile")
    public String showProfile(Principal principal, ModelMap map){

        User user = userService.findUserByLogin(principal.getName());

        map.addAttribute("user", user);

        return "profile";
    }




}
