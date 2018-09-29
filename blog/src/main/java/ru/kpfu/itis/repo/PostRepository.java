package ru.kpfu.itis.repo;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import ru.kpfu.itis.model.entities.Post;
import ru.kpfu.itis.model.entities.PostLikeCount;

import java.util.List;

@Repository
public interface PostRepository extends JpaRepository<Post, Integer>{

    List<Post> findAll();


    @Query(
            value = "select new ru.kpfu.itis.model.entities.PostLikeCount(count(l), p) from Post as p left join p.postLikes as l group by p order by count(l) desc",
            countQuery = "select count (p) from Post p"
    )
    Page<PostLikeCount> findAllWithLikesCountDesc(Pageable pageable);


    @Query(
            value = "select new ru.kpfu.itis.model.entities.PostLikeCount(count(l), p) from Post as p left join p.postLikes as l group by p order by count(l) asc",
            countQuery = "select count (p) from Post p"
    )
    Page<PostLikeCount> findAllWithLikesCountAsc(Pageable pageable);

}
