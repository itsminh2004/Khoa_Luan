package khoaluantotnghiep.service;

import khoaluantotnghiep.model.ProductComment;
import java.util.List;

public interface IProductCommentService {
    ProductComment save(ProductComment comment);

    List<ProductComment> findByProductId(int productId);

    List<ProductComment> findAll();

    void delete(int id);
}
