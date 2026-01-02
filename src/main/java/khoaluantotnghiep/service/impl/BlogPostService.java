package khoaluantotnghiep.service.impl;

import khoaluantotnghiep.Dao.impl.BlogPostDao;
import khoaluantotnghiep.model.BlogPost;
import khoaluantotnghiep.service.IBlogPostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BlogPostService implements IBlogPostService {
    @Autowired
    private BlogPostDao postDao;
    @Override public List<BlogPost> findAllPublished(){ return postDao.findAllPublished(); }
    @Override public List<BlogPost> findAll(){ return postDao.findAll(); }
    @Override public BlogPost findById(int id){ return postDao.findById(id); }
    @Override public BlogPost findBySlug(String slug){ return postDao.findBySlug(slug); }
    @Override public BlogPost save(BlogPost p){ return postDao.save(p); }
    @Override public BlogPost update(BlogPost p){ return postDao.update(p); }
    @Override public void delete(int id){ postDao.delete(id); }
}
