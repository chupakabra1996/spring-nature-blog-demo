package ru.kpfu.itis.model.ajax.commentWrite;

import com.fasterxml.jackson.annotation.JsonView;
import ru.kpfu.itis.model.ajax.Views;

public class CommentAjax {

    @JsonView(Views.Public.class)
    private String comment;

    @JsonView(Views.Public.class)
    private String dateTime;

    @JsonView(Views.Public.class)
    private String userProfileLink;

    @JsonView(Views.Public.class)
    private String imageLink;

    @JsonView(Views.Public.class)
    private String userName;


    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getDateTime() {
        return dateTime;
    }

    public void setDateTime(String dateTime) {
        this.dateTime = dateTime;
    }

    public String getUserProfileLink() {
        return userProfileLink;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public void setUserProfileLink(String userProfileLink) {
        this.userProfileLink = userProfileLink;
    }

    public String getImageLink() {
        return imageLink;
    }

    public void setImageLink(String imageLink) {
        this.imageLink = imageLink;
    }
}
