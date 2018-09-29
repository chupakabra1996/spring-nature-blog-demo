package ru.kpfu.itis.model.forms;

import org.hibernate.validator.constraints.NotBlank;
import org.springframework.web.multipart.MultipartFile;

public class PostForm {

    @NotBlank
    private String title;

    @NotBlank
    private String content;


    private MultipartFile image;


    public PostForm() {
    }

    public PostForm(String title, String content, MultipartFile image) {
        this.title = title;
        this.content = content;
        this.image = image;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public MultipartFile getImage() {
        return image;
    }

    public void setImage(MultipartFile image) {
        this.image = image;
    }
}
