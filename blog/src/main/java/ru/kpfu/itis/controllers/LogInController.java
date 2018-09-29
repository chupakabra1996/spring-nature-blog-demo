package ru.kpfu.itis.controllers;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/login")
public class LogInController {

    private static final Logger log = Logger.getLogger(LogInController.class);

    private MessageSourceAccessor msa;


    @Autowired
    public void setMessageSourceAccessor(MessageSource messageSourceAccessor) {
        this.msa = new MessageSourceAccessor(messageSourceAccessor);
    }


    @PreAuthorize("isAnonymous()")
    @RequestMapping(method = RequestMethod.GET)
    public String login(
            HttpSession session,
            @RequestParam(value = "error",  required = false) String error,
            @RequestParam(value = "logout", required = false) String logout,
            ModelMap map)
    {
        if (error == null){
            if (logout != null){
                map.put("logout", msa.getMessage("login.logout.success"));
            }
            return "login";
        }else{
            if (error.equals("token"))
                map.put("error", msa.getMessage("login.error.token"));
            else
                map.put("error", msa.getMessage("login.error.valid"));
        }


        return "login";
    }



}
