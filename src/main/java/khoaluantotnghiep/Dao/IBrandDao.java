package khoaluantotnghiep.Dao;

import khoaluantotnghiep.model.Brand;

import java.util.List;

public interface IBrandDao {
    List<Brand> findAll();
    List<Brand> findAllPaging(int offset, int limit);
    int countAll();
    Brand findOne(int id);
    Brand findByAlias(String alias);
    Brand insert(Brand brand);
    Brand update(Brand brand);
    void delete(int id);
}
