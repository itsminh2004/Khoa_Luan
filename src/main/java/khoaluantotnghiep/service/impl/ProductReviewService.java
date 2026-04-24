package khoaluantotnghiep.service.impl;

import khoaluantotnghiep.Dao.IProductReviewDao;
import khoaluantotnghiep.dto.ProductRatingDto;
import khoaluantotnghiep.model.ProductReview;
import khoaluantotnghiep.service.IProductReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Map;

@Service
public class ProductReviewService implements IProductReviewService {
    @Autowired
    private IProductReviewDao reviewDao;

    @Override
    public ProductReview save(ProductReview review) {
        return reviewDao.insert(review);
    }

    @Override
    public List<ProductReview> findByProductId(int productId) {
        return reviewDao.findByProductId(productId);
    }

    @Override
    public List<ProductReview> findAll() {
        return reviewDao.findAll();
    }

    @Override
    public void delete(int id) {
        reviewDao.delete(id);
    }
    @Override
    public Map<Integer, ProductRatingDto> getRatingsByProductIds(List<Integer> productIds) {
        return reviewDao.getRatingsByProductIds(productIds);
    }
}
