package khoaluantotnghiep.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Product {
    private int id;
    private String name;
    private String description;
    private double price;
    private double priceSale;
    private int stock;
    private Date createdDate;
    private boolean active;
    private int categoryId;
    private int seriesId;           // 🔹 thêm
    private String alias;
    private String image;
    private String categoryName;
    private String seriesName;      // 🔹 thêm
    private boolean hasVariants;
    private String defaultRam;
    private String defaultRom;

    private ProductCategory productCategory;
    private List<ProductImage> images = new ArrayList<>();

    // === Getters/Setters ===
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public double getPriceSale() { return priceSale; }
    public void setPriceSale(double priceSale) { this.priceSale = priceSale; }

    public int getStock() { return stock; }
    public void setStock(int stock) { this.stock = stock; }

    public Date getCreatedDate() { return createdDate; }
    public void setCreatedDate(Date createdDate) { this.createdDate = createdDate; }

    public boolean isActive() { return active; }
    public void setActive(boolean active) { this.active = active; }

    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }

    public int getSeriesId() { return seriesId; }     // 🔹 thêm
    public void setSeriesId(int seriesId) { this.seriesId = seriesId; }

    public String getAlias() { return alias; }
    public void setAlias(String alias) { this.alias = alias; }

    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }

    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }

    public String getSeriesName() { return seriesName; } // 🔹 thêm
    public void setSeriesName(String seriesName) { this.seriesName = seriesName; }

    public boolean isHasVariants() { return hasVariants; }
    public void setHasVariants(boolean hasVariants) { this.hasVariants = hasVariants; }

    public String getDefaultRam() { return defaultRam; }
    public void setDefaultRam(String defaultRam) { this.defaultRam = defaultRam; }

    public String getDefaultRom() { return defaultRom; }
    public void setDefaultRom(String defaultRom) { this.defaultRom = defaultRom; }

    public ProductCategory getProductCategory() { return productCategory; }
    public void setProductCategory(ProductCategory productCategory) { this.productCategory = productCategory; }

    public List<ProductImage> getImages() { return images; }
    public void setImages(List<ProductImage> images) { this.images = images; }

    public void addImage(String imageUrl) {
        ProductImage img = new ProductImage();
        img.setImageUrl(imageUrl);
        this.images.add(img);
    }
}
