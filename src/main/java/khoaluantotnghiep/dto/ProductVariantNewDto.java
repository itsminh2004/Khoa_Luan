package khoaluantotnghiep.dto;

import java.math.BigDecimal;
import java.util.List;

public class ProductVariantNewDto {
    private int id;
    private int colorId;
    private Integer ramRomId;

    private String colorName;
    private String ramRom; // "8GB / 256GB"

    private BigDecimal price;
    private BigDecimal priceSale;
    private int stock;
    private List<String> images;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getColorId() {
        return colorId;
    }

    public void setColorId(int colorId) {
        this.colorId = colorId;
    }

    public Integer getRamRomId() {
        return ramRomId;
    }

    public void setRamRomId(Integer ramRomId) {
        this.ramRomId = ramRomId;
    }

    public String getColorName() {
        return colorName;
    }

    public void setColorName(String colorName) {
        this.colorName = colorName;
    }

    public String getRamRom() {
        return ramRom;
    }

    public void setRamRom(String ramRom) {
        this.ramRom = ramRom;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public BigDecimal getPriceSale() {
        return priceSale;
    }

    public void setPriceSale(BigDecimal priceSale) {
        this.priceSale = priceSale;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public List<String> getImages() {
        return images;
    }

    public void setImages(List<String> images) {
        this.images = images;
    }
}
