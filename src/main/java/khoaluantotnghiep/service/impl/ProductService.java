package khoaluantotnghiep.service.impl;

import khoaluantotnghiep.Dao.IProductDao;
import khoaluantotnghiep.model.Product;
import khoaluantotnghiep.service.IProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductService implements IProductService {
    @Autowired
    private IProductDao productDao;


    @Override
    public Product save(Product product) {
        return productDao.insert(product);
    }

    @Override
    public Product update(Product updateProduct) {
        return productDao.update(updateProduct);
    }

    @Override
    public void delete(int id) {
        productDao.delete(id);
    }

    @Override
    public Product findOne(int id) {
        return productDao.findOne(id);
    }

    @Override
    public Product findCategoryById(int id) {
        return productDao.findCategoryById(id);
    }

    @Override
    public List<Product> findAllPaging(int offset, int limit) {
        return productDao.findAllPaging(offset, limit);
    }

    @Override
    public int countAll() {
        return productDao.countAll();
    }

    @Override
    public List<Product> findAll() {
        return productDao.findAll();
    }



}
