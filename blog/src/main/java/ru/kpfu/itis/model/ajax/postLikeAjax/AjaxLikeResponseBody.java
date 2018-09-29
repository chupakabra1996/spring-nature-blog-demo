package ru.kpfu.itis.model.ajax.postLikeAjax;

import com.fasterxml.jackson.annotation.JsonView;
import ru.kpfu.itis.model.ajax.Views;

public class AjaxLikeResponseBody {

    @JsonView(Views.Public.class)
    private String msg;


    @JsonView(Views.Public.class)
    private String code;


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
}
