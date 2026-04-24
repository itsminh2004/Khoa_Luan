package khoaluantotnghiep.dto;

public class ProductSpecificationDto {
    private String attrKey; // Internal key
    private String attrName; // For frontend (backward compatibility)
    private String attrValue;

    public String getAttrKey() {
        return attrKey;
    }

    public void setAttrKey(String attrKey) {
        this.attrKey = attrKey;
        this.attrName = attrKey; // Keep them in sync
    }

    public String getAttrName() {
        return attrName;
    }

    public void setAttrName(String attrName) {
        this.attrName = attrName;
    }

    public String getAttrValue() {
        return attrValue;
    }

    public void setAttrValue(String attrValue) {
        this.attrValue = attrValue;
    }
}
