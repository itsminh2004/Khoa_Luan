package khoaluantotnghiep.dto;

import java.sql.Timestamp;

public class OrderItemDto {
    private int id;
    private int orderId;
    private int productId;
    private Integer variantId;
    private int quantity;
    private double price;
    private Timestamp createdAt;
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

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
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

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
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



