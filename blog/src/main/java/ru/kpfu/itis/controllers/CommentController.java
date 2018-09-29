package ru.kpfu.itis.controllers;

import com.fasterxml.jackson.annotation.JsonView;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.method.annotation.MvcUriComponentsBuilder;
import ru.kpfu.itis.model.ajax.commentWrite.AjaxRequestBody;
import ru.kpfu.itis.model.ajax.commentWrite.AjaxResponseBody;
import ru.kpfu.itis.model.ajax.commentWrite.CommentAjax;
import ru.kpfu.itis.model.ajax.Views;
import ru.kpfu.itis.model.entities.Comment;
import ru.kpfu.itis.model.entities.Post;
import ru.kpfu.itis.model.entities.User;
import ru.kpfu.itis.service.CommentService;
import ru.kpfu.itis.service.PostService;
import ru.kpfu.itis.service.UserService;

import javax.validation.Valid;
import java.security.Principal;


@RestController
@RequestMapping(value = "/comment")
public class CommentController {

    private static final Logger log = Logger.getLogger(CommentController.class);

    @Autowired
    private PostService postService;

    @Autowired
    private UserService userService;

    @Autowired
    private CommentService commentService;



    @JsonView(Views.Public.class)
    @PreAuthorize("isAuthenticated()")
    @RequestMapping(value = "/perform_comment_ajax", method = RequestMethod.POST)

    public AjaxResponseBody performComment(
            @RequestBody @Valid AjaxRequestBody data,
            BindingResult br,
            Principal principal
    ) {
        AjaxResponseBody result = new AjaxResponseBody();
        result.setCode("400");

        if (br.hasErrors()){
            result.setMsg("Comment is not valid!");
            return result;
        }

        //creating data entity to save
        Comment saveComment = new Comment();
        saveComment.setComment(data.getComment());

        //finding required user and post
        Post post = postService.findPost(data.getPostId());
        User user = userService.findUserByLogin(principal.getName());

        saveComment.setPost(post);
        saveComment.setUser(user);

        //saving
        try {
            Comment c = commentService.saveComment(saveComment);
            CommentAjax commentAjax = new CommentAjax();
            commentAjax.setComment(c.getComment());
            commentAjax.setDateTime(c.getDateTime().toString());
            commentAjax.setImageLink(user.getImage());
            commentAjax.setUserName(user.getLogin());

            commentAjax.setUserProfileLink(MvcUriComponentsBuilder
                    .fromMappingName("UC#showGuestProfile").arg(0, user.getId()).build());

            result.setResult(commentAjax);

        } catch (Throwable e) {
            //if any exception
            log.error("Can't save data", e);
            result.setMsg("Can't save data!");
            return result;
        }

        result.setCode("200");
        result.setMsg("Success");

        return result;
    }

}
