package khoaluantotnghiep.Dao;

import khoaluantotnghiep.model.ProductComment;
import java.util.List;

public interface IProductCommentDao {
    ProductComment insert(ProductComment comment);
    List<ProductComment> findByProductId(int productId);
    List<ProductComment> findAll();
    void delete(int id);

}
