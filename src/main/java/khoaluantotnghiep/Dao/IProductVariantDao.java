package khoaluantotnghiep.Dao;

import khoaluantotnghiep.model.ProductVariant;

import java.util.List;

public interface IProductVariantDao {
    ProductVariant save(ProductVariant v);
    ProductVariant update(ProductVariant v);
    void delete(int id);
    List<ProductVariant> findByProductId(int productId);
    ProductVariant findById(int id);
}
