package khoaluantotnghiep.service.impl;

import khoaluantotnghiep.Dao.IProductImageDao;
import khoaluantotnghiep.model.ProductImage;
import khoaluantotnghiep.service.IProductImageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductImageService implements IProductImageService {
    @Autowired
    private IProductImageDao productImageDao;

    @Override
    public ProductImage insert(ProductImage productImage) {
        return productImageDao.insert(productImage);
    }

    @Override
    public void delete(int id) {
        productImageDao.delete(id);
    }

    @Override
    public List<ProductImage> findByProductId(int productId) {
        return productImageDao.findByProductId(productId);
    }

    @Override
    public List<ProductImage> findByVariantId(int variantId) {
        return productImageDao.findByVariantId(variantId);
    }

    @Override
    public ProductImage findOne(int id) {
        return productImageDao.findOne(id);
    }

    @Override
    public List<ProductImage> findByColorId(int colorId) {
        return productImageDao.findByColorId(colorId);
    }

    @Override
    public void deleteByColorId(int colorId) {
        productImageDao.deleteByColorId(colorId);
    }
}
