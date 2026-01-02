package khoaluantotnghiep.model;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class ProductVariant {
    private int id;
    private int productId;
    private String color;
    private String configuration;
    private BigDecimal price;
    private BigDecimal priceSale;
    private int stock;
    private String sku;
    private Date createdAt;

    private List<ProductImage> images = new ArrayList<>();

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public String getColor() { return color; }
    public void setColor(String color) { this.color = color; }

    public String getConfiguration() { return configuration; }
    public void setConfiguration(String configuration) { this.configuration = configuration; }

    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }

    public BigDecimal getPriceSale() { return priceSale; }
    public void setPriceSale(BigDecimal priceSale) { this.priceSale = priceSale; }

    public int getStock() { return stock; }
    public void setStock(int stock) { this.stock = stock; }

    public String getSku() { return sku; }
    public void setSku(String sku) { this.sku = sku; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt;
    }
    public List<ProductImage> getImages() { return images; }
    public void setImages(List<ProductImage> images) { this.images = images; }
}

