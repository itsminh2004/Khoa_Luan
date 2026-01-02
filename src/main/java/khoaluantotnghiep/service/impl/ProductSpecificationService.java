package khoaluantotnghiep.service.impl;

import khoaluantotnghiep.Dao.IProductSpecificationDao;
import khoaluantotnghiep.model.ProductSpecification;
import khoaluantotnghiep.service.IProductSpecificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductSpecificationService implements IProductSpecificationService {
    @Autowired
    private IProductSpecificationDao productSpecificationDao;

    @Override public ProductSpecification save(ProductSpecification s) { return productSpecificationDao.save(s); }
    @Override public ProductSpecification update(ProductSpecification s) { return productSpecificationDao.update(s); }
    @Override public void delete(int id) { productSpecificationDao.delete(id); }
    @Override public List<ProductSpecification> findByProductId(int productId) { return productSpecificationDao.findByProductId(productId); }
    @Override public ProductSpecification findById(int id) { return productSpecificationDao.findById(id); }
}
