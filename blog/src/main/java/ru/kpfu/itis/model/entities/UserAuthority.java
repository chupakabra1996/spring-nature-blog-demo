package ru.kpfu.itis.model.entities;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.springframework.security.core.GrantedAuthority;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

/**
 * Authority table
 */

@Entity
@Table(name = "user_role")
public class UserAuthority implements GrantedAuthority {

    @Id
    @Column(name = "id", unique = true, nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;


    @NotBlank
    @Length(max = 50)
    @Column(length = 50, name = "authority", unique = true, nullable = false)
    private String authority;


    @ManyToMany(mappedBy = "authorities", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private Set<User> users = new HashSet<>();

    public UserAuthority() {
    }

    public UserAuthority(String authority) {
        this.authority = authority;
    }

    //getters and setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Override
    public String getAuthority() {
        return authority;
    }

    public void setAuthority(String authority) {
        this.authority = authority;
    }

    public Set<User> getUsers() {
        return users;
    }

    public void setUsers(Set<User> users) {
        this.users = users;
    }


    //equals and hashcode

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        UserAuthority that = (UserAuthority) o;

        return id == that.id && authority.equals(that.authority);

    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + authority.hashCode();
        return result;
    }
}
