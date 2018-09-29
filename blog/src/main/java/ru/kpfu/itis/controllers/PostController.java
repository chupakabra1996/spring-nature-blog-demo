package ru.kpfu.itis.controllers;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.data.domain.Page;
import org.springframework.security.access.prepost.PostAuthorize;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.method.annotation.MvcUriComponentsBuilder;
import ru.kpfu.itis.model.entities.Comment;
import ru.kpfu.itis.model.entities.Post;
import ru.kpfu.itis.model.entities.User;
import ru.kpfu.itis.model.forms.PostForm;
import ru.kpfu.itis.service.CommentService;
import ru.kpfu.itis.service.PostService;
import ru.kpfu.itis.service.UserService;

import javax.servlet.ServletContext;
import javax.validation.Valid;
import java.security.Principal;
import java.util.List;

@Controller
public class PostController {

    //Logger
    private static final Logger log = Logger.getLogger(PostController.class);

    @Autowired
    private PostService postService;

    @Autowired
    private UserService userService;

    @Autowired
    private CommentService commentService;

    @Autowired
    private ServletContext context;

    private MessageSourceAccessor msa;

    public void setMsa(MessageSource messageSource) {
        msa = new MessageSourceAccessor(messageSource);
    }


    @PreAuthorize("isAuthenticated()")
    @RequestMapping(value = "/post/{id}", method = RequestMethod.GET)
    public String showPost(
            @PathVariable("id") int id,
            Principal principal,
            ModelMap map
    ) {

        User user = userService.findUserByLogin(principal.getName());
        Post post = postService.findPost(id);

        Page<Post> recentPosts = postService.findRecentPosts();

        List<Comment> commentList = commentService.getSortedComments(post);

        map.addAttribute("currentUser", user);
        map.addAttribute("recentPosts", recentPosts.getContent());
        map.addAttribute("post", post);
        map.addAttribute("user", post.getUser());
        map.addAttribute("likes", post.getPostLikes());
        map.addAttribute("comments", commentList);

        return "single_post";
    }


    @RequestMapping(value = "/posts/{type}/", method = RequestMethod.GET)
    public String showAllPosts(
            @PathVariable(value = "type") String t,          //path var sorting type, all, recent, popular
            @RequestParam(defaultValue = "1") Integer p,        //page number
            @RequestParam(defaultValue = "desc") String s,      //sorting by desc or asc
            ModelMap map
    ) {

        Page<Post> posts = postService.getPostPageSortedByTypes(t, p - 1, s);

        int current = posts.getNumber() + 1;
        int begin = Math.max(1, current - 5);
        int end = Math.min(begin + 10, posts.getTotalPages());

        map.addAttribute("page", posts);
        map.addAttribute("current", current);
        map.addAttribute("begin", begin);
        map.addAttribute("end", end);
        map.addAttribute("type", t);

        return "blog";
    }


    @RequestMapping(method = RequestMethod.GET, value = "/post/write")
    @PreAuthorize("isAuthenticated()")
    public String showWritePost(ModelMap map) {


        map.addAttribute("post", new PostForm());

        return "post_writing";
    }


    @RequestMapping(method = RequestMethod.POST, value = "/post/save")
    @PreAuthorize("isAuthenticated()")
    public String savePost(
            @Valid @ModelAttribute("post") PostForm postForm,
            BindingResult bindingResult,
            Principal principal
    ) {


        if (postForm.getImage().getSize() == 0) {
            bindingResult.rejectValue("image", "image.fileUpload.empty");
        }

        if (bindingResult.hasErrors()) {
            log.error("has errors");
            return "post_writing";
        }

        User user = userService.findUserByLogin(principal.getName());

        Post p = new Post();
        p.setUser(user);

        p = postService.savePost(p, postForm);

        log.error("success!");


        return "redirect:" + MvcUriComponentsBuilder.fromMappingName("PC#showPost").arg(0, p.getId()).build();
    }

}
