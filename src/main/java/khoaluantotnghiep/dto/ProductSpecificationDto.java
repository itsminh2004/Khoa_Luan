package khoaluantotnghiep.dto;

public class ProductSpecificationDto {
    private String attrKey;  // Changed from 'key' to match tb_product_attributes.attr_key
    private String attrValue;


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
}


