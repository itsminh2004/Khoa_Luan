package khoaluantotnghiep.service.impl;

import khoaluantotnghiep.Dao.IBrandDao;
import khoaluantotnghiep.model.Brand;
import khoaluantotnghiep.service.IBrandService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BrandService implements IBrandService {

    @Autowired
    private IBrandDao brandDao;

    @Override
    public List<Brand> findAll() {
        return brandDao.findAll();
    }

    @Override
    public List<Brand> findAllPaging(int offset, int limit) {
        return brandDao.findAllPaging(offset, limit);
    }

    @Override
    public int countAll() {
        return brandDao.countAll();
    }

    @Override
    public Brand findOne(int id) {
        return brandDao.findOne(id);
    }

    @Override
    public Brand findByAlias(String alias) {
        return brandDao.findByAlias(alias);
    }

    @Override
    public Brand insert(Brand brand) {
        return brandDao.insert(brand);
    }

    @Override
    public Brand update(Brand brand) {
        return brandDao.update(brand);
    }

    @Override
    public void delete(int id) {
        brandDao.delete(id);
    }

    @Override
    public void saveAll(List<Brand> items) {
        for (Brand item : items) {
            brandDao.insert(item);
        }
    }
}
