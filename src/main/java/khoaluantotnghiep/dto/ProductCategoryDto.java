package khoaluantotnghiep.dto;

public class ProductCategoryDto {
    private int id;
    private String name;
    private String description;
    private String image;
    private String alias;
    private Integer rootCategoryId;

    public ProductCategoryDto() {
    }

    public ProductCategoryDto(int id, String name, String description, String image, String alias,
                              Integer rootCategoryId) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.image = image;
        this.alias = alias;
        this.rootCategoryId = rootCategoryId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getAlias() {
        return alias;
    }

    public void setAlias(String alias) {
        this.alias = alias;
    }

    public Integer getRootCategoryId() {
        return rootCategoryId;
    }

    public void setRootCategoryId(Integer rootCategoryId) {
        this.rootCategoryId = rootCategoryId;
    }
}
