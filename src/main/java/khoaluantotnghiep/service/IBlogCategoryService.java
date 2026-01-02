package khoaluantotnghiep.service;

import khoaluantotnghiep.model.BlogCategory;

import java.util.List;

public interface IBlogCategoryService {
    BlogCategory save(BlogCategory p);
    BlogCategory update(BlogCategory p);
    void delete(int id);
    List<BlogCategory> findAll();
    BlogCategory findById(int id);

}
