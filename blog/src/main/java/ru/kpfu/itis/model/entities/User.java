package ru.kpfu.itis.model.entities;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.core.CredentialsContainer;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import ru.kpfu.itis.model.constraints.FieldMatch;
import ru.kpfu.itis.model.constraints.ValidEmail;

import javax.persistence.*;
import javax.validation.constraints.Size;
import java.util.Collection;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Users table
 */

@FieldMatch(message = "Passwords don't match")

@Entity
@Table(name = "users")
public class User implements CredentialsContainer, UserDetails {

    @Id
    @Column(name = "id", unique = true, nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Size(min = 1, max = 128)
    @NotBlank
    @Column(nullable = false, length = 128)
    private String name;

    @Size(min = 1, max = 128)
    @NotBlank
    @Column(nullable = false, unique = true)
    private String login;


    @ValidEmail
    @Length(min = 4, max = 128)
    @Column(unique = true, nullable = false, length = 128)
    private String email;


    @NotBlank
    @Size(min = 6, max = 64)
    @Column(nullable = false)
    private String password;

    @NotBlank
    @Transient
    private String passwordRepeat;  //it is transient, because we don't need to store it


    @Column(name = "registered")
    @Temporal(TemporalType.TIMESTAMP)
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date registeredDate;


    @NotBlank
    @Column(name = "sex")
    private String sex;


    @Column(name = "enabled", nullable = false)
    private boolean enabled;


    @Column(name = "image")
    private String image;


    @ManyToMany(fetch = FetchType.EAGER, cascade = {CascadeType.MERGE})
    @JoinTable(
            name = "user_user_role",
            joinColumns = @JoinColumn(name = "user"),
            inverseJoinColumns = @JoinColumn(name = "user_role")
    )
    private Set<UserAuthority> authorities = new HashSet<>();


    @OneToMany(fetch = FetchType.LAZY, mappedBy = "user", cascade = CascadeType.ALL)
    private Set<Post> posts = new HashSet<>();

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "user", cascade = CascadeType.ALL)
    private Set<Comment> comments = new HashSet<>();

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "user", cascade = CascadeType.ALL)
    private Set<PostLike> likes = new HashSet<>();

    public User() {

    }

    @PrePersist
    public void createProfile() {
        enabled = false;
        registeredDate = new Date();
    }


    //getters and setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getPasswordRepeat() {
        return passwordRepeat;
    }


    public Set<PostLike> getLikes() {
        return likes;
    }

    public void setLikes(Set<PostLike> likes) {
        this.likes = likes;
    }

    public void setPasswordRepeat(String passwordRepeat) {
        this.passwordRepeat = passwordRepeat;
    }

    public Date getRegisteredDate() {
        return registeredDate;
    }

    public void setRegisteredDate(Date registeredDate) {
        this.registeredDate = registeredDate;
    }

    public void addAuthority(UserAuthority authority) {
        authorities.add(authority);
    }

    public Set<Post> getPosts() {
        return posts;
    }

    public void setPosts(Set<Post> posts) {
        this.posts = posts;
    }

    public Set<Comment> getComments() {
        return comments;
    }

    public void setComments(Set<Comment> comments) {
        this.comments = comments;
    }

    @Override
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return authorities;
    }


    //Overrides

    public void setAuthorities(Set<UserAuthority> authorities) {
        this.authorities = authorities;
    }

    @Override
    public String getUsername() {
        return login;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return enabled;
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }

    @Override
    public void eraseCredentials() {
        password = null;
    }





    //equals and hashcode


    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        User user = (User) o;

        if (id != user.id) return false;
        if (!name.equals(user.name)) return false;
        if (!login.equals(user.login)) return false;
        return email.equals(user.email);

    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + name.hashCode();
        result = 31 * result + login.hashCode();
        result = 31 * result + email.hashCode();
        return result;
    }
}
