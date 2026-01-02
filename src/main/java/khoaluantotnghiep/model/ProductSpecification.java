package khoaluantotnghiep.model;

import java.util.Date;

public class ProductSpecification {
    private int id;
    private int productId;
    private String attrKey;  // Changed from 'key' to match tb_product_attributes.attr_key
    private String attrValue; // Changed from 'value' to match tb_product_attributes.attr_value
    private Date createdDate;

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

    public String getAttrKey() {
        return attrKey;
    }

    public void setAttrKey(String attrKey) {
        this.attrKey = attrKey;
    }

    public String getAttrValue() {
        return attrValue;
    }

    public void setAttrValue(String attrValue) {
        this.attrValue = attrValue;
    }

    // Backward compatibility methods
    public String getKey() {
        return attrKey;
    }

    public void setKey(String key) {
        this.attrKey = key;
    }

    public String getValue() {
        return attrValue;
    }

    public void setValue(String value) {
        this.attrValue = value;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }
}
