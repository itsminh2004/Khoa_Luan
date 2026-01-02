package khoaluantotnghiep.service.impl;

import khoaluantotnghiep.Dao.impl.BlogCommentDao;
import khoaluantotnghiep.model.BlogComment;
import khoaluantotnghiep.service.IBlogCommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BlogCommentService implements IBlogCommentService {
    @Autowired
    private BlogCommentDao blogCommentDao;

    @Override
    public BlogComment save(BlogComment c) {
        return blogCommentDao.save(c);
    }

    @Override
    public void delete(int id) {
        blogCommentDao.delete(id);
    }

    @Override
    public List<BlogComment> findAllWithDetails() {
        return blogCommentDao.findAllWithDetails();
    }

    @Override
    public List<BlogComment> findByPostId(int postId) {
        return blogCommentDao.findByPostId(postId);
    }
}
