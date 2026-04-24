package khoaluantotnghiep.Dao;

import khoaluantotnghiep.dto.ProductRatingDto;
import khoaluantotnghiep.model.ProductReview;
import java.util.List;
import java.util.Map;

public interface IProductReviewDao {
    ProductReview insert(ProductReview review);
    List<ProductReview> findByProductId(int productId);
    List<ProductReview> findAll();
    void delete(int id);
    Map<Integer, ProductRatingDto> getRatingsByProductIds(List<Integer> productIds);
}
