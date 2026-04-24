package khoaluantotnghiep.dto;

import java.util.Date;

public class CartItemDto {
    private int id;
    private int userId;
    private int productId;
    private Integer variantId;
    private int quantity;
    private Date createdAt;
    private ProductDto product;
    private ProductVariantNewDto variant;

    public Integer getVariantId() {
        return variantId;
    }

    public void setVariantId(Integer variantId) {
        this.variantId = variantId;
    }

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

    public ProductDto getProduct() {
        return product;
    }

    public void setProduct(ProductDto product) {
        this.product = product;
    }

    public ProductVariantNewDto getVariant() {
        return variant;
    }

    public void setVariant(ProductVariantNewDto variant) {
        this.variant = variant;
    }
}


