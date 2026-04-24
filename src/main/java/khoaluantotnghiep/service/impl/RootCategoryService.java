package khoaluantotnghiep.service.impl;

import khoaluantotnghiep.Dao.IRootCategoryDao;
import khoaluantotnghiep.model.RootCategory;
import khoaluantotnghiep.service.IRootCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RootCategoryService implements IRootCategoryService {
    @Autowired
    private IRootCategoryDao rootCategoryDao;

    @Override
    public RootCategory save(RootCategory rootCategory) {
        return rootCategoryDao.insert(rootCategory);
    }

    @Override
    public RootCategory update(RootCategory rootCategory) {
        return rootCategoryDao.update(rootCategory);
    }

    @Override
    public void delete(int id) {
        rootCategoryDao.delete(id);
    }

    @Override
    public RootCategory findOne(int id) {
        return rootCategoryDao.findOne(id);
    }

    @Override
    public List<RootCategory> findAll() {
        return rootCategoryDao.findAll();
    }

    @Override
    public List<RootCategory> findAllPaging(int offset, int limit) {
        return rootCategoryDao.findAllPaging(offset, limit);
    }

    @Override
    public int countAll() {
        return rootCategoryDao.countAll();
    }

    @Override
    public void saveAll(List<RootCategory> items) {
        for (RootCategory item : items) {
            rootCategoryDao.insert(item);
        }
    }
}
