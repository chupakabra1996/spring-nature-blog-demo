package ru.kpfu.itis.repo;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ru.kpfu.itis.model.entities.PostLike;

@Repository
public interface LikeRepository extends JpaRepository<PostLike, Integer> {

}
