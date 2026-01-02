package khoaluantotnghiep.Dao;

import khoaluantotnghiep.model.ProductColor;

import java.util.List;

public interface IProductColorDao {
    ProductColor save(ProductColor color);
    ProductColor update(ProductColor color);
    void delete(int id);
    List<ProductColor> findByProductId(int productId);
    ProductColor findById(int id);
}

