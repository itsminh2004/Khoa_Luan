package khoaluantotnghiep.dto;

import khoaluantotnghiep.model.Banner;

public class BannerDto {
    private int id;
    private String title;
    private String imageUrl;
    private Integer productId;
    private String position;
    private int sortOrder;
    private boolean active;

    public BannerDto() {
    }
    public BannerDto(Banner banner) {
        if (banner != null) {
            this.id = banner.getId();
            this.title = banner.getTitle();
            this.imageUrl = banner.getImageUrl();
            this.productId = banner.getProductId();
            this.position = banner.getPosition();
            this.sortOrder = banner.getSortOrder();
        }
    }
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public int getSortOrder() {
        return sortOrder;
    }

    public void setSortOrder(int sortOrder) {
        this.sortOrder = sortOrder;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }
}
