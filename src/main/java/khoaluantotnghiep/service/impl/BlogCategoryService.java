package khoaluantotnghiep.service.impl;

import khoaluantotnghiep.Dao.IBlogCategoryDao;
import khoaluantotnghiep.model.BlogCategory;
import khoaluantotnghiep.service.IBlogCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class BlogCategoryService implements IBlogCategoryService {
    @Autowired
    private IBlogCategoryDao blogCategoryDao;

    @Override
    public BlogCategory save(BlogCategory p) {
        return blogCategoryDao.save(p);
    }

    @Override
    public BlogCategory update(BlogCategory p) {
        return blogCategoryDao.update(p);
    }

    @Override
    public void delete(int id) {
       blogCategoryDao.delete(id);
    }

    @Override
    public List<BlogCategory> findAll() {
        return blogCategoryDao.findAll();
    }

    @Override
    public BlogCategory findById(int id) {
        return blogCategoryDao.findById(id);
    }
}
