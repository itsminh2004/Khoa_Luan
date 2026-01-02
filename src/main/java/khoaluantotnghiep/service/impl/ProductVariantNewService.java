package khoaluantotnghiep.service.impl;

import khoaluantotnghiep.Dao.IProductVariantNewDao;
import khoaluantotnghiep.model.ProductVariantNew;
import khoaluantotnghiep.service.IProductVariantNewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductVariantNewService implements IProductVariantNewService {
    @Autowired
    private IProductVariantNewDao productVariantNewDao;

    @Override
    public ProductVariantNew save(ProductVariantNew variant) {
        return productVariantNewDao.save(variant);
    }

    @Override
    public ProductVariantNew update(ProductVariantNew variant) {
        return productVariantNewDao.update(variant);
    }

    @Override
    public void delete(int id) {
        productVariantNewDao.delete(id);
    }

    @Override
    public List<ProductVariantNew> findByProductId(int productId) {
        return productVariantNewDao.findByProductId(productId);
    }

    @Override
    public ProductVariantNew findById(int id) {
        return productVariantNewDao.findById(id);
    }

    @Override
    public ProductVariantNew findByColorIdAndRamRomId(int colorId, int ramRomId) {
        return productVariantNewDao.findByColorIdAndRamRomId(colorId, ramRomId);
    }

    @Override
    public List<ProductVariantNew> findByColorId(int colorId) {
        return productVariantNewDao.findByColorId(colorId);
    }

    @Override
    public void deleteByColorId(int colorId) {
        productVariantNewDao.deleteByColorId(colorId);
    }
}


