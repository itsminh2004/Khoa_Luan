package khoaluantotnghiep.service.impl;

import khoaluantotnghiep.Dao.IProductCategory;
import khoaluantotnghiep.model.ProductCategory;
import khoaluantotnghiep.service.IProductCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductCategoryService implements IProductCategoryService {
    @Autowired
    private IProductCategory productCategory;


    @Override
    public ProductCategory insert(ProductCategory category) {
        if (category.getParentId() == null || category.getParentId() == 0) {
            category.setParentId(null);
        }
        return productCategory.insert(category);
    }

    @Override
    public ProductCategory update(ProductCategory updateCategory) {
        return productCategory.update(updateCategory);
    }

    @Override
    public void delete(int id) {
        productCategory.delete(id);
    }

    @Override
    public ProductCategory findOne(int id) {
        return productCategory.findOne(id);
    }

    @Override
    public List<ProductCategory> findAll() {
        return productCategory.findAll();
    }

    @Override
    public List<ProductCategory> findParentCategories() {
        return productCategory.findParentCategories();
    }

    @Override
    public List<ProductCategory> findAllPaging(int offset, int limit) {
        return productCategory.findAllPaging(offset, limit);
    }

    @Override
    public int countAll() {
        return productCategory.countAll();
    }


}
