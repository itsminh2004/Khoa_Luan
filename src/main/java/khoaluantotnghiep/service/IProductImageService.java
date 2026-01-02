package khoaluantotnghiep.service;

import khoaluantotnghiep.model.ProductImage;

import java.util.List;

public interface IProductImageService {
    ProductImage insert(ProductImage productImage);
    void delete(int id);
    List<ProductImage> findByProductId(int productId);
    List<ProductImage> findByVariantId(int variantId);
    List<ProductImage> findByColorId(int colorId);
    ProductImage findOne(int id);
    void deleteByColorId(int colorId);
}
