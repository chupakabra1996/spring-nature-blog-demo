package ru.kpfu.itis.repo;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import ru.kpfu.itis.model.entities.UserAuthority;

import java.util.Set;

@Repository
public interface UserAuthorityRepository extends CrudRepository<UserAuthority, Integer> {

    @Query("SELECT authority FROM UserAuthority authority WHERE authority.authority = :role_user")
    UserAuthority findByAuthority(@Param("role_user") String userRole);


    Set<UserAuthority> findAll();
}
