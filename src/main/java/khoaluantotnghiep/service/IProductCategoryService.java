package khoaluantotnghiep.service;

import khoaluantotnghiep.model.ProductCategory;

import java.util.List;

public interface IProductCategoryService {
    ProductCategory insert(ProductCategory category);
    ProductCategory update(ProductCategory updateCategory);
    void delete(int id);
    ProductCategory findOne(int id);
    List<ProductCategory> findAll();
    List<ProductCategory> findParentCategories();
    List<ProductCategory> findAllPaging(int offset, int limit);
    int countAll();

}
