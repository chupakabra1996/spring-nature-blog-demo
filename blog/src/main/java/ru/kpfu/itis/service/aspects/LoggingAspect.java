package ru.kpfu.itis.service.aspects;

import org.apache.log4j.Logger;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

@Aspect
public class LoggingAspect {

    private static final Logger logger = Logger.getLogger(LoggingAspect.class);

    @Around("@annotation(ru.kpfu.itis.utils.Loggable)")
    public Object logAround(ProceedingJoinPoint joinPoint) throws Throwable {

        Object[] args = joinPoint.getArgs();

        DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Calendar cal = Calendar.getInstance();

        String date = format.format(cal.getTime());   //date
        String methodName = formMethodSignature(joinPoint.getSignature().getName(), args); //method name

        Object o = joinPoint.proceed(joinPoint.getArgs());

        String retValue = o == null ? "void" : o.getClass().getSimpleName();        //ret value

        logger.error("date : " + date);
        logger.error("method :" + methodName);
        logger.error("returned value : " + retValue);

        return o;
    }

    private String formMethodSignature(String name, Object[] args) {
        if (args == null || args.length == 0) {
            name += "(  )";
        } else {
            name += "( ";
            for (int i = 0; i < args.length; i++) {
                if (i == args.length - 1) {
                    name += args[i].getClass().getSimpleName();
                } else {
                    if (args[i]!= null)
                        name += args[i].getClass().getSimpleName() + ", ";
                }
            }
            name += " )";
        }
        return name;
    }
}
