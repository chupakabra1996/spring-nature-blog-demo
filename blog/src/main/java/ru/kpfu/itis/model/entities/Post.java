package ru.kpfu.itis.model.entities;

import org.hibernate.annotations.Type;
import org.hibernate.validator.constraints.Length;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "posts")
public class Post {


    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;


    @Length(min = 1, max = 256, message = "error")
    @Column(name = "title")
    private String title;


    @Length(min = 1, max = Integer.MAX_VALUE)
    @Column(name = "content")
    @Type(type = "text")
    private String content;


    @Column(name = "date")
    @Temporal(TemporalType.TIMESTAMP)
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date dateTime;


    @Column(name = "featured_image")
    private String featuredImage;


    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;


    @OneToMany(fetch = FetchType.EAGER, mappedBy = "post", cascade = CascadeType.ALL)
    private Set<PostLike> postLikes = new HashSet<>();


    @OneToMany(fetch = FetchType.LAZY, mappedBy = "post", cascade = CascadeType.ALL)
    private Set<Comment> comments = new HashSet<>();

    public Post() {

    }


    @PrePersist
    public void onCreate(){
        dateTime = new Date();
    }

    //getters and setter

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public Date getDateTime() {
        return dateTime;
    }

    public void setDateTime(Date dateTime) {
        this.dateTime = dateTime;
    }

    public String getFeaturedImage() {
        return featuredImage;
    }

    public void setFeaturedImage(String featuredImage) {
        this.featuredImage = featuredImage;
    }

    public User getUser() {
        return user;
    }


    public void setUser(User user) {
        this.user = user;
    }

    public Set<PostLike> getPostLikes() {
        return postLikes;
    }

    public void setPostLikes(Set<PostLike> postLikes) {
        this.postLikes = postLikes;
    }

    public Set<Comment> getComments() {
        return comments;
    }

    public void setComments(Set<Comment> comments) {
        this.comments = comments;
    }


    public void addLike(){
        postLikes.add(new PostLike());
    }


    //equals and hashcode

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Post post = (Post) o;

        if (id != post.id) return false;
        if (!title.equals(post.title)) return false;
        if (!content.equals(post.content)) return false;
        if (!dateTime.equals(post.dateTime)) return false;
        if (!featuredImage.equals(post.featuredImage)) return false;
        return user.equals(post.user);

    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + title.hashCode();
        result = 31 * result + content.hashCode();
        if (dateTime != null){
            result = 31 * result + dateTime.hashCode();
        }
        if (featuredImage != null) {
            result = 31 * result + featuredImage.hashCode();
        }
        return result;
    }

}
