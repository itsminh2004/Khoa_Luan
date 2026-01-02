package khoaluantotnghiep.service;

import khoaluantotnghiep.model.ProductSpecification;

import java.util.List;

public interface IProductSpecificationService {
    ProductSpecification save(ProductSpecification s);
    ProductSpecification update(ProductSpecification s);
    void delete(int id);
    List<ProductSpecification> findByProductId(int productId);
    ProductSpecification findById(int id);
}
