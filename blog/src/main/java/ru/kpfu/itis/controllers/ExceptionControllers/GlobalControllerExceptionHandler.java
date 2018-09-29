package ru.kpfu.itis.controllers.ExceptionControllers;

import org.apache.log4j.Logger;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.NoHandlerFoundException;
import ru.kpfu.itis.exceptions.NotFoundException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@ControllerAdvice
public class GlobalControllerExceptionHandler {

    private static final Logger log = Logger.getLogger(GlobalControllerExceptionHandler.class);


    @ExceptionHandler(Throwable.class)
    public ModelAndView handleError(HttpServletRequest request, HttpServletResponse resp, Exception e)   {

        if (!request.getRequestURI().equals("/favicon.ico")){
            log.error("error exception handler, the requested url : " + request.getRequestURI(), e);
        }



        ModelAndView mav = new ModelAndView("error");

        if (e instanceof AccessDeniedException){
            mav.addObject("code", 403);
        }else if (e instanceof NoHandlerFoundException){
            mav.addObject("code", 404);
        } else if (e instanceof NotFoundException) {
            mav.addObject("code", 404);
        }else if (e instanceof MethodArgumentTypeMismatchException){
            resp.setStatus(404);
            mav.addObject("code", 404);
        }else if (e instanceof HttpRequestMethodNotSupportedException){
            resp.setStatus(404);
            mav.addObject("code", 404);
        }else{
            resp.setStatus(500);
            mav.addObject("code", 500);
        }
        return mav;
    }
}
