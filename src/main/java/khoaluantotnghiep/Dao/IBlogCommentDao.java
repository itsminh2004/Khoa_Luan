package khoaluantotnghiep.Dao;

import khoaluantotnghiep.model.BlogComment;

import java.util.List;

public interface IBlogCommentDao {
    BlogComment save(BlogComment c);
    void delete(int id);
    List<BlogComment> findAllWithDetails();
    List<BlogComment> findByPostId(int postId);
}
