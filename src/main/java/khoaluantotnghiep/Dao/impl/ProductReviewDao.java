package khoaluantotnghiep.Dao.impl;

import khoaluantotnghiep.Dao.IProductReviewDao;
import khoaluantotnghiep.dto.ProductRatingDto;
import khoaluantotnghiep.mapper.ProductReviewMapper;
import khoaluantotnghiep.model.ProductReview;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Repository
public class ProductReviewDao implements IProductReviewDao {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public ProductReview insert(ProductReview review) {
        String sql = "INSERT INTO tb_product_reviews (product_id, user_id, rating, comment) VALUES (?, ?, ?, ?)";
        jdbcTemplate.update(sql, review.getProductId(), review.getUserId(), review.getRating(), review.getComment());
        return review;
    }

    @Override
    public List<ProductReview> findByProductId(int productId) {
        String sql = "SELECT r.*, u.full_name FROM tb_product_reviews r JOIN tb_users u ON r.user_id = u.id WHERE r.product_id = ? ORDER BY r.created_at DESC";
        return jdbcTemplate.query(sql, new ProductReviewMapper(), productId);
    }

    @Override
    public List<ProductReview> findAll() {
        String sql = "SELECT r.*, u.full_name, p.Name FROM tb_product_reviews r JOIN tb_users u ON r.user_id = u.id JOIN tb_product p ON r.product_id = p.Id ORDER BY r.created_at DESC";
        return jdbcTemplate.query(sql, new ProductReviewMapper());
    }

    @Override
    public void delete(int id) {
        jdbcTemplate.update("DELETE FROM tb_product_reviews WHERE id=?", id);
    }
    @Override
    public Map<Integer, ProductRatingDto> getRatingsByProductIds(List<Integer> productIds) {
        if (productIds == null || productIds.isEmpty()) {
            return Collections.emptyMap();
        }

        String inClause = productIds.stream()
                .map(String::valueOf)
                .collect(Collectors.joining(","));

        String sql = "SELECT product_id, AVG(rating) as avg_rating, COUNT(id) as count " +
                "FROM tb_product_reviews " +
                "WHERE product_id IN (" + inClause + ") " +
                "GROUP BY product_id";

        Map<Integer, ProductRatingDto> ratings = new HashMap<>();
        jdbcTemplate.query(sql, (ResultSet rs) -> {
            while (rs.next()) {
                int productId = rs.getInt("product_id");
                double avgRating = rs.getDouble("avg_rating");
                int count = rs.getInt("count");
                ratings.put(productId, new ProductRatingDto(productId, avgRating, count));
            }
            return ratings;
        });

        return ratings;
    }
}
