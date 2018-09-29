package ru.kpfu.itis.model.constraints;

import ru.kpfu.itis.model.entities.User;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

public class FieldMatchValidator implements ConstraintValidator<FieldMatch, Object> {

    @Override
    public void initialize(FieldMatch constraintAnnotation) {

    }

    @Override
    public boolean isValid(Object obj, ConstraintValidatorContext context){

        if(obj instanceof User){
            User user = (User)obj;
            return user.getPassword().equals(user.getPasswordRepeat());
        }

        return false;
    }
}