package ru.kpfu.itis.exceptions;

public class PostException extends RuntimeException {

    private String type;

    public PostException() {
        super();
    }

    public PostException(String message, String type) {
        super(message);
        this.type = type;
    }

    public String getType() {
        return type;
    }

    public PostException(String message, Throwable cause) {
        super(message, cause);
    }

    public PostException(Throwable cause) {
        super(cause);
    }
}
