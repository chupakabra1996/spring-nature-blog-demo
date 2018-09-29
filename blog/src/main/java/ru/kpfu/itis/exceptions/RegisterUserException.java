package ru.kpfu.itis.exceptions;

public class RegisterUserException extends Exception {

    private int code;

    public RegisterUserException(String message, int code){
        super(message);
        this.code = code;
    }

    public RegisterUserException() {
        super();
    }

    public RegisterUserException(String message) {
        super(message);
    }

    public RegisterUserException(String message, Throwable cause) {
        super(message, cause);
    }

    public RegisterUserException(Throwable cause) {
        super(cause);
    }

    public int getCode() {
        return code;
    }
}
