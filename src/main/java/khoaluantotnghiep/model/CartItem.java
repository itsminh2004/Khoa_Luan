package khoaluantotnghiep.model;

import java.util.Date;

public class CartItem {
    private int id;
    private int userId;
    private int productId;
    private Integer variantId;
    private int quantity;
    private Date createdAt;
    private Product product;
    private ProductVariantNew variant;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public Integer getVariantId() {
        return variantId;
    }

    public void setVariantId(Integer variantId) {
        this.variantId = variantId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public ProductVariantNew getVariant() {
        return variant;
    }

    public void setVariant(ProductVariantNew variant) {
        this.variant = variant;
    }
}


