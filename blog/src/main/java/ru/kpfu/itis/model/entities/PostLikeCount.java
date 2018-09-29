package ru.kpfu.itis.model.entities;

public class PostLikeCount {

    private Long likeCount;

    private Post post;

    public PostLikeCount(Long likeCount, Post post) {
        this.likeCount = likeCount;
        this.post = post;
    }

    public Long getLikeCount() {
        return likeCount;
    }

    public void setLikeCount(Long likeCount) {
        this.likeCount = likeCount;
    }

    public Post getPost() {
        return post;
    }

    public void setPost(Post post) {
        this.post = post;
    }


    @Override
    public String toString() {
        return post.toString() + ", count = " + likeCount;
    }
}
