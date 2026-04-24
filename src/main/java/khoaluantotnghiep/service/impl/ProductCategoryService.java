package khoaluantotnghiep.service.impl;

import khoaluantotnghiep.Dao.IProductCategory;
import khoaluantotnghiep.Dao.IRootCategoryDao;
import khoaluantotnghiep.model.ProductCategory;
import khoaluantotnghiep.service.IProductCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductCategoryService implements IProductCategoryService {
    @Autowired
    private IProductCategory productCategory;

    @Autowired
    private IRootCategoryDao rootCategoryDao;

    @Override
    public ProductCategory insert(ProductCategory category) {
        if (category.getRootCategoryId() == null || category.getRootCategoryId() == 0) {
            category.setRootCategoryId(null);
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


    @Override
    public void saveAll(List<ProductCategory> items) {
        List<khoaluantotnghiep.model.RootCategory> roots = rootCategoryDao.findAll();
        for (ProductCategory item : items) {
            if (item.getRootCategoryName() != null && !item.getRootCategoryName().isEmpty()) {
                for (khoaluantotnghiep.model.RootCategory root : roots) {
                    if (root.getName().equalsIgnoreCase(item.getRootCategoryName())) {
                        item.setRootCategoryId(root.getId());
                        break;
                    }
                }
            }
            this.insert(item);
        }
    }
}
