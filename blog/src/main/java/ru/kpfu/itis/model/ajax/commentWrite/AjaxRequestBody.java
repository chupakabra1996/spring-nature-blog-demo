package ru.kpfu.itis.model.ajax.commentWrite;


import org.hibernate.validator.constraints.NotBlank;

import javax.validation.constraints.Min;

public class AjaxRequestBody {


    @NotBlank
    private String comment;

    @Min(value = 1)
    private int postId;


    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

}
