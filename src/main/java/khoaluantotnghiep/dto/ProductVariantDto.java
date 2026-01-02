package khoaluantotnghiep.dto;

import java.math.BigDecimal;
import java.util.List;

public class ProductVariantDto {
    private int id;
    private String color;
    private String configuration;
    private BigDecimal price;
    private BigDecimal priceSale;
    private int stock;
    private String sku;
    private List<String> images; // danh sách url ảnh cho màu này

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

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

    public List<String> getImages() { return images; }
    public void setImages(List<String> images) { this.images = images; }
}


