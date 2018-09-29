package ru.kpfu.itis.service;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.kpfu.itis.model.entities.PostLike;
import ru.kpfu.itis.repo.LikeRepository;

@Service
public class LikeService {

    private static final Logger log = Logger.getLogger(LikeService.class);

    @Autowired
    private LikeRepository likeRepository;


    public void addLikeToPost(PostLike postLike){

        likeRepository.save(postLike);
    }

}
