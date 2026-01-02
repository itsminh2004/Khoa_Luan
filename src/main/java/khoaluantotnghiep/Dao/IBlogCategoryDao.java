package khoaluantotnghiep.Dao;

import khoaluantotnghiep.model.BlogCategory;

import java.util.List;

public interface IBlogCategoryDao {
    List<BlogCategory> findAll();
    BlogCategory findById(int id);
    BlogCategory save(BlogCategory c);
    BlogCategory update(BlogCategory c);
    void delete(int id);
}
