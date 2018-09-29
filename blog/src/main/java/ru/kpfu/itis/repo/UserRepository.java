package ru.kpfu.itis.repo;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import ru.kpfu.itis.model.entities.User;

@Repository
public interface UserRepository extends CrudRepository<User,Integer>, JpaSpecificationExecutor<User> {

    User findByEmailIgnoreCase(String email);

    User findByLoginIgnoreCase(String login);
}
