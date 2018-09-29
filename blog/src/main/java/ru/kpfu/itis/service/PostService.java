package ru.kpfu.itis.service;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;
import ru.kpfu.itis.exceptions.NotFoundException;
import ru.kpfu.itis.model.entities.Post;
import ru.kpfu.itis.model.entities.PostLikeCount;
import ru.kpfu.itis.model.forms.PostForm;
import ru.kpfu.itis.repo.PostRepository;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;


@Service
public class PostService {

    //default page size
    private static final int DEFAULT_PAGE_SIZE = 5;

    //Logger
    private static final Logger log = Logger.getLogger(PostService.class);


    //uploads directory for images
    private final String DIR_PATH = "/Users/Ramil/Desktop/uploads";

    private final String IMAGES = DIR_PATH + "/post_featured_images";
    private final String PROFILES = DIR_PATH + "/user_profile_images";


    @Autowired
    private PostRepository postRepository;


    /**
     * Save the post
     *
     * @param post - post to be saved
     */
    public Post savePost(Post post) {
        try {
            return postRepository.save(post);
        } catch (RuntimeException e) {
            log.fatal("can't save post", e);
            throw e;
        }
    }



    public Post savePost(Post post, PostForm postForm){

        try {
            //generating name of the image
            String saveUUID = UUID.nameUUIDFromBytes(postForm.getImage().getBytes()).toString();
            post.setFeaturedImage(saveUUID + "." + getExtension(postForm.getImage().getContentType()));

        } catch (IOException e) {
            log.error("Error when generating UUID", e);
            throw new RuntimeException("Exception when trying generate UUID");
        }

        //saving post's image in filesystem
        savePostImage(postForm.getImage(), post.getFeaturedImage());

        post.setContent(postForm.getContent());
        post.setTitle(postForm.getTitle());

        log.error("trying to save post");
        return postRepository.save(post);

    }


    private String getExtension(String file){
        return file.split("/")[1];
    }


    /**
     * Finds the post by id
     * If no page found throws NotFoundException
     *
     * @param id - the posts id
     * @return Post entity
     */
    public Post findPost(int id) {

        Post post = postRepository.findOne(id);

        checkPost(post);    //checking the post

        return postRepository.findOne(id);
    }


    /**
     * Finds Page<Post>
     * If no page found throws NotFoundException
     *
     * @param page - the requested page (should be from 0)
     * @param type - the type os sorting (should be asc or desc) else desc is used
     * @return the Page<Post> sorted by date
     */
    public Page<Post> findAllSortedByDate(int page, String type) {

        checkPage(page); //checking the page

        Page<Post> posts = postRepository.findAll(new PageRequest(page, DEFAULT_PAGE_SIZE,
                new Sort("asc".equalsIgnoreCase(type) ? Sort.Direction.ASC : Sort.Direction.DESC, "dateTime")));

        checkPages(posts);  //checking posts

        return posts;
    }


    /**
     * Finds recent posts by published date
     *
     * @return Page<Post>
     */
    public Page<Post> findRecentPosts() {

        return postRepository.findAll(new PageRequest(0, DEFAULT_PAGE_SIZE, Sort.Direction.DESC, "dateTime"));
    }


    /**
     * Finds Page<Post>
     * If no found throws NotFoundException
     *
     * @param page - the requested page
     * @param type - the type of sorting (should be asc or desc) else desc is used
     * @return the Page<Post> sorted by popularity
     */
    public Page<Post> findAllSortedByPopularity(int page, String type) {

        checkPage(page);

        //the PostLikeCount page
        Page<PostLikeCount> postLikeCountPage;

        switch (type.toLowerCase()) {

            case "asc":
                postLikeCountPage = postRepository.findAllWithLikesCountAsc(new PageRequest(page, DEFAULT_PAGE_SIZE));
                break;
            case "desc":
                postLikeCountPage = postRepository.findAllWithLikesCountDesc(new PageRequest(page, DEFAULT_PAGE_SIZE));
                break;
            default:
                postLikeCountPage = postRepository.findAllWithLikesCountDesc(new PageRequest(page, DEFAULT_PAGE_SIZE));
        }

        checkCountPages(postLikeCountPage); //checking

        //forming Page<Post>
        List<Post> postList = new ArrayList<>(postLikeCountPage.getNumberOfElements());

        for (PostLikeCount plk : postLikeCountPage) {
            postList.add(plk.getPost());
        }

        return new PageImpl<>(postList, new PageRequest(page, DEFAULT_PAGE_SIZE),
                postLikeCountPage.getTotalElements());
    }


    /**
     * Finds all posts (sorted by dateTime)
     * If no page found then NotFoundException will be thrown
     *
     * @param page - the requested page
     * @return the Page<Post>
     */
    public Page<Post> findAll(int page) {

        checkPage(page);

        Page<Post> posts = postRepository.findAll(new PageRequest(page, DEFAULT_PAGE_SIZE, Sort.Direction.DESC, "dateTime"));

        checkPages(posts);

        return posts;
    }


    /**
     * Saves the post's image (featured image)
     *
     * @param input - MultiPart file (should be one of the jpg, jpeg, png)
     */
    public void savePostImage(MultipartFile input, String name) {
        try {
            FileCopyUtils.copy(input.getBytes(), new File(IMAGES + File.separator + name));
        } catch (IOException e) {
            log.debug("Exception when copying file", e);
        }
    }


    public Page<Post> getPostPageSortedByTypes(String type, int page, String t) {

        switch (type.toLowerCase()) {

            case "all":
                return findAll(page);
            case "recent":
                return findAllSortedByDate(page, t);
            case "popular":
                return findAllSortedByPopularity(page, t);
            default:
                throw new IllegalArgumentException("the type is not illegal value! It should be popular, all or recent!");
        }
    }


    /**
     * Checks whether the page is null or less than 0
     *
     * @param page - requested page
     */
    private void checkPage(Integer page) {
        if (page == null || page < 0) {
            throw new IllegalArgumentException("Illegal page : " + page + " argument. Should be less than 0 and not null.");
        }
    }


    /**
     * Checks whether the page is null or has any content
     *
     * @param posts - page of posts
     */
    private void checkPages(Page<Post> posts) {
        if (posts == null || !posts.hasContent()) {
            throw new NotFoundException("Page hasn't got any content. Page is empty.");
        }
    }


    /**
     * Checks whether the post is null
     *
     * @param post - Post entity
     */
    private void checkPost(Post post) {
        if (post == null) {
            throw new NotFoundException("Post is not found");
        }
    }


    /**
     * Checks whether the page is null or has any content
     *
     * @param page - page of posts
     */
    private void checkCountPages(Page<PostLikeCount> page) {
        if (page == null || !page.hasContent()) {
            throw new NotFoundException("Page han't got any content. Page is empty.");
        }
    }


    /**
     * Returns post content in short and formatted state
     *
     * @param post - Post
     * @return String
     */
    public String getPostContent(Post post) {

        StringBuilder content = new StringBuilder(post.getContent());

        if (content.length() <= 100) {
            return content.toString();
        }

        content.delete(101, content.length());

        content.append(" [...]");

        return content.toString();
    }


    public String getDIR_PATH() {
        return DIR_PATH;
    }

    public String getIMAGES() {
        return IMAGES;
    }

    public String getPROFILES() {
        return PROFILES;
    }
}
