package khoaluantotnghiep.service;

import khoaluantotnghiep.model.Product;

import java.util.List;

public interface IProductService {
    List<Product> findAll();
    Product save(Product product);
    Product update(Product updateProduct);
    void delete(int id);
    Product findOne(int id);
    Product findCategoryById(int id);
    List<Product> findAllPaging(int offset, int limit);
    int countAll();
}
