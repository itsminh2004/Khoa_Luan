package khoaluantotnghiep.model;

import java.math.BigDecimal;

public class ProductVariantNew {
    private int id;
    private int productId;
    private int colorId;
    private int ramRomId;
    private BigDecimal price;
    private BigDecimal priceSale;
    private int stock;

    // Related objects (for convenience)
    private ProductColor color;
    private ProductRamRom ramRom;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getColorId() {
        return colorId;
    }

    public void setColorId(int colorId) {
        this.colorId = colorId;
    }

    public int getRamRomId() {
        return ramRomId;
    }

    public void setRamRomId(int ramRomId) {
        this.ramRomId = ramRomId;
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

    public ProductColor getColor() {
        return color;
    }

    public void setColor(ProductColor color) {
        this.color = color;
    }

    public ProductRamRom getRamRom() {
        return ramRom;
    }

    public void setRamRom(ProductRamRom ramRom) {
        this.ramRom = ramRom;
    }
}

