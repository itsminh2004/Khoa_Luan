package khoaluantotnghiep.service.impl;

import khoaluantotnghiep.Dao.IProductColorDao;
import khoaluantotnghiep.model.ProductColor;
import khoaluantotnghiep.service.IProductColorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductColorService implements IProductColorService {
    @Autowired
    private IProductColorDao productColorDao;

    @Override
    public ProductColor save(ProductColor color) {
        return productColorDao.save(color);
    }

    @Override
    public ProductColor update(ProductColor color) {
        return productColorDao.update(color);
    }

    @Override
    public void delete(int id) {
        productColorDao.delete(id);
    }

    @Override
    public List<ProductColor> findByProductId(int productId) {
        return productColorDao.findByProductId(productId);
    }

    @Override
    public ProductColor findById(int id) {
        return productColorDao.findById(id);
    }
}

