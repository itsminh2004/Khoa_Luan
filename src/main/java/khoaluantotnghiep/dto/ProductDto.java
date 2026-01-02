package khoaluantotnghiep.dto;

public class ProductDto {
    private int id;
    private String name;
    private String description;
    private double price;
    private double priceSale;
    private int stock;
    private String image;
    private String categoryName;
    private String alias;
    private Integer seriesId;
    private String seriesName;
    // frontend: danh sách biến thể + thông số kỹ thuật
    private java.util.List<ProductVariantDto> variants;
    private java.util.List<ProductSpecificationDto> specs;

    public ProductDto() {}

    public ProductDto(int id, String name, String description, double price, double priceSale, int stock, String image, String categoryName, String alias) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.priceSale = priceSale;
        this.stock = stock;
        this.image = image;
        this.categoryName = categoryName;
        this.alias = alias;
    }

    public Integer getSeriesId() { return seriesId; }
    public void setSeriesId(Integer seriesId) { this.seriesId = seriesId; }

    public String getSeriesName() { return seriesName; }
    public void setSeriesName(String seriesName) { this.seriesName = seriesName; }

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

    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }

    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }

    public String getAlias() { return alias; }
    public void setAlias(String alias) { this.alias = alias; }

    public java.util.List<ProductVariantDto> getVariants() { return variants; }
    public void setVariants(java.util.List<ProductVariantDto> variants) { this.variants = variants; }

    public java.util.List<ProductSpecificationDto> getSpecs() { return specs; }
    public void setSpecs(java.util.List<ProductSpecificationDto> specs) { this.specs = specs; }
}
