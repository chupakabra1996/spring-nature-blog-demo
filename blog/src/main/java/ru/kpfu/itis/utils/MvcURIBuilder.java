package ru.kpfu.itis.utils;

import freemarker.template.TemplateMethodModelEx;
import freemarker.template.TemplateModelException;
import org.springframework.web.servlet.mvc.method.annotation.MvcUriComponentsBuilder;

import java.util.List;

public class MvcURIBuilder implements TemplateMethodModelEx {

    @Override
    public Object exec(List arguments) throws TemplateModelException {
        if (arguments == null || arguments.isEmpty()){
            throw new IllegalArgumentException("Empty argument list was found");
        }

        return MvcUriComponentsBuilder.fromMappingName(arguments.get(0).toString());
    }

}
