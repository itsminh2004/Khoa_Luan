package khoaluantotnghiep.model;

import java.util.Date;
import java.util.List;

public class ProductComment {
    private int id;
    private int productId;
    private int userId;
    private Integer parentId;
    private String comment;
    private boolean isAdminReply;
    private Date createdAt;

    // Joint fields
    private String productName;
    private String userName;
    private List<ProductComment> replies;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public Integer getParentId() { return parentId; }
    public void setParentId(Integer parentId) { this.parentId = parentId; }

    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }

    public boolean isAdminReply() { return isAdminReply; }
    public void setAdminReply(boolean adminReply) { isAdminReply = adminReply; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }

    public List<ProductComment> getReplies() { return replies; }
    public void setReplies(List<ProductComment> replies) { this.replies = replies; }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }
}
