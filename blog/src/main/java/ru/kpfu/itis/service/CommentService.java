package ru.kpfu.itis.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import ru.kpfu.itis.model.entities.Comment;
import ru.kpfu.itis.model.entities.Post;
import ru.kpfu.itis.repo.CommentRepository;

import java.util.List;

@Service
public class CommentService {

    @Autowired
    private CommentRepository commentRepository;


    /**
     * Saves comment
     *
     * @param comment - comment
     * @return saved Comment
     */
    public Comment saveComment(Comment comment) {

        return commentRepository.save(comment);
    }


    /**
     * Returns comment by id
     *
     * @param id - comment's id
     * @return Comment
     */
    public Comment getCommentById(int id) {

        return commentRepository.findOne(id);
    }


    /**
     * Returns sorted comments by date
     *
     * @param post
     * @return
     */
    public List<Comment> getSortedComments(Post post) {

        return commentRepository.findAllByPostId(new Sort(Sort.Direction.DESC, "dateTime"), post.getId());
    }

}
