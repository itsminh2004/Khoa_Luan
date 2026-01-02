package khoaluantotnghiep.service;

import khoaluantotnghiep.model.BlogComment;

import java.util.List;

public interface IBlogCommentService {
    BlogComment save(BlogComment c);
    void delete(int id);
    List<BlogComment> findAllWithDetails();
    List<BlogComment> findByPostId(int postId);
}
