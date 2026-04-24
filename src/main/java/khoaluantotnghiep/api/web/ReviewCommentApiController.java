package khoaluantotnghiep.api.web;

import khoaluantotnghiep.dto.ProductRatingDto;
import khoaluantotnghiep.model.ProductComment;
import khoaluantotnghiep.model.ProductReview;
import khoaluantotnghiep.service.IProductCommentService;
import khoaluantotnghiep.service.IProductReviewService;
import khoaluantotnghiep.utils.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.HashMap;

@CrossOrigin(origins = { "http://localhost:5500", "http://127.0.0.1:5500" })
@RestController
@RequestMapping("/api")
public class ReviewCommentApiController {

    @Autowired
    private IProductReviewService reviewService;

    @Autowired
    private IProductCommentService commentService;

    // Lấy danh sách đánh giá của 1 sản phẩm
    @GetMapping(value = "/products/{productId}/reviews", produces = "application/json; charset=UTF-8")
    public List<ProductReview> getReviews(@PathVariable("productId") int productId) {
        return reviewService.findByProductId(productId);
    }
    //Lấy rating của tất cả sản phẩm
    @GetMapping(value = "/products/ratings", produces = "application/json; charset=UTF-8")
    public Map<Integer, ProductRatingDto> getRatings(@RequestParam("ids") List<Integer> productIds) {
        return reviewService.getRatingsByProductIds(productIds);
    }

    // Gửi đánh giá
    @PostMapping(value = "/products/{productId}/reviews", produces = "application/json; charset=UTF-8")
    public Map<String, Object> postReview(@PathVariable("productId") int productId, @RequestBody ProductReview review) {
        Map<String, Object> response = new HashMap<>();
        int userId = SecurityUtils.getCurrentUserId();
        if (userId <= 0) {
            response.put("status", "error");
            response.put("message", "Vui lòng đăng nhập để đánh giá.");
            return response;
        }
        review.setProductId(productId);
        review.setUserId(userId);
        if (review.getCreatedAt() == null) {
            review.setCreatedAt(new java.util.Date());
        }
        reviewService.save(review);
        response.put("status", "success");
        response.put("message", "Cảm ơn bạn đã đánh giá sản phẩm!");
        return response;
    }

    // Lấy danh sách bình luận của sản phẩm
    @GetMapping(value = "/products/{productId}/comments", produces = "application/json; charset=UTF-8")
    public List<ProductComment> getComments(@PathVariable("productId") int productId) {
        return commentService.findByProductId(productId);
    }

    // Gửi bình luận
    @PostMapping(value = "/products/{productId}/comments", produces = "application/json; charset=UTF-8")
    public Map<String, Object> postComment(@PathVariable("productId") int productId,
                                           @RequestBody ProductComment comment) {
        Map<String, Object> response = new HashMap<>();
        int userId = SecurityUtils.getCurrentUserId();
        if (userId <= 0) {
            response.put("status", "error");
            response.put("message", "Vui lòng đăng nhập để bình luận.");
            return response;
        }
        comment.setProductId(productId);
        comment.setUserId(userId);
        if (comment.getCreatedAt() == null) {
            comment.setCreatedAt(new java.util.Date());
        }
        commentService.save(comment);
        response.put("status", "success");
        response.put("message", "Bình luận đã được gửi!");
        return response;
    }
}
