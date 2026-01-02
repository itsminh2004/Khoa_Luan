package khoaluantotnghiep.service;

import khoaluantotnghiep.model.BlogPost;

import java.util.List;

public interface IBlogPostService {
    BlogPost save(BlogPost p);
    BlogPost update(BlogPost p);
    void delete(int id);
    List<BlogPost> findAllPublished();
    List<BlogPost> findAll();
    BlogPost findById(int id);
    BlogPost findBySlug(String slug);
}
