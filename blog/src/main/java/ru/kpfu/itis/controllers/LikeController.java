package ru.kpfu.itis.controllers;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import ru.kpfu.itis.model.ajax.postLikeAjax.AjaxLikeRequestBody;
import ru.kpfu.itis.model.ajax.postLikeAjax.AjaxLikeResponseBody;
import ru.kpfu.itis.model.entities.Post;
import ru.kpfu.itis.model.entities.PostLike;
import ru.kpfu.itis.model.entities.User;
import ru.kpfu.itis.service.LikeService;
import ru.kpfu.itis.service.PostService;
import ru.kpfu.itis.service.UserService;

import java.security.Principal;

@RestController
public class LikeController {

    private static final Logger log = Logger.getLogger(LikeController.class);

    @Autowired
    private UserService userService;

    @Autowired
    private PostService postService;

    @Autowired
    private LikeService likeService;


    @RequestMapping(method = RequestMethod.POST, value = "perform_like_ajax")
    public AjaxLikeResponseBody performLike(@RequestBody AjaxLikeRequestBody data, Principal principal){

        AjaxLikeResponseBody result = new AjaxLikeResponseBody();

        User user = userService.findUserByLogin(principal.getName());

        Post post = postService.findPost(data.getPostId());

        result.setCode("200");
        result.setMsg("Success!");

        try{
            likeService.addLikeToPost(new PostLike(user, post));
        }catch (RuntimeException e){
//            log.error("Error when saving like", e);
            result.setCode("400");
            result.setMsg("Can't like it!");
        }

        return result;
    }
}
