package khoaluantotnghiep.dto;

public class ProductRatingDto {
    private int productId;
    private double averageRating;
    private int reviewCount;

    public ProductRatingDto() {}

    public ProductRatingDto(int productId, double averageRating, int reviewCount) {
        this.productId = productId;
        this.averageRating = averageRating;
        this.reviewCount = reviewCount;
    }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public double getAverageRating() { return averageRating; }
    public void setAverageRating(double averageRating) { this.averageRating = averageRating; }

    public int getReviewCount() { return reviewCount; }
    public void setReviewCount(int reviewCount) { this.reviewCount = reviewCount; }
}
