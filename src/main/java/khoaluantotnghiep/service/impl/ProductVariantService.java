package khoaluantotnghiep.service.impl;

import khoaluantotnghiep.Dao.IProductVariantDao;
import khoaluantotnghiep.model.ProductVariant;
import khoaluantotnghiep.service.IProductVariantService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductVariantService implements IProductVariantService {
    @Autowired
    private IProductVariantDao productVariantDao;

    @Override public ProductVariant save(ProductVariant v) { return productVariantDao.save(v); }
    @Override public ProductVariant update(ProductVariant v) { return productVariantDao.update(v); }
    @Override public void delete(int id) { productVariantDao.delete(id); }
    @Override public List<ProductVariant> findByProductId(int productId) { return productVariantDao.findByProductId(productId); }
    @Override public ProductVariant findById(int id) { return productVariantDao.findById(id); }
}
