package ru.kpfu.itis.model.ajax.commentWrite;

import com.fasterxml.jackson.annotation.JsonView;
import ru.kpfu.itis.model.ajax.Views;

public class AjaxResponseBody {


    @JsonView(Views.Public.class)
    private String msg;

    @JsonView(Views.Public.class)
    private String code;

    @JsonView(Views.Public.class)
    private CommentAjax result;


    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public CommentAjax getResult() {
        return result;
    }

    public void setResult(CommentAjax result) {
        this.result = result;
    }
}

