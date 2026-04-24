package khoaluantotnghiep.Dao.impl;

import khoaluantotnghiep.Dao.IProductCommentDao;
import khoaluantotnghiep.mapper.ProductCommentMapper;
import khoaluantotnghiep.model.ProductComment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public class ProductCommentDao implements IProductCommentDao {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public ProductComment insert(ProductComment comment) {
        String sql = "INSERT INTO tb_product_comments (product_id, user_id, parent_id, comment, is_admin_reply) VALUES (?, ?, ?, ?, ?)";
        jdbcTemplate.update(sql, comment.getProductId(), comment.getUserId(), comment.getParentId(),
                comment.getComment(), comment.isAdminReply());
        return comment;
    }

    @Override
    public List<ProductComment> findByProductId(int productId) {
        String sql = "SELECT c.*, u.full_name FROM tb_product_comments c JOIN tb_users u ON c.user_id = u.id WHERE c.product_id = ? AND c.parent_id IS NULL ORDER BY c.created_at DESC";
        List<ProductComment> mainComments = jdbcTemplate.query(sql, new ProductCommentMapper(), productId);
        for (ProductComment pc : mainComments) {
            pc.setReplies(findReplies(pc.getId()));
        }
        return mainComments;
    }

    private List<ProductComment> findReplies(int parentId) {
        String sql = "SELECT c.*, u.full_name FROM tb_product_comments c JOIN tb_users u ON c.user_id = u.id WHERE c.parent_id = ? ORDER BY c.created_at ASC";
        return jdbcTemplate.query(sql, new ProductCommentMapper(), parentId);
    }

    @Override
    public List<ProductComment> findAll() {
        String sql = "SELECT c.*, u.full_name, p.Name AS product_name " +
                "FROM tb_product_comments c " +
                "JOIN tb_users u ON c.user_id = u.id " +
                "JOIN tb_product p ON c.product_id = p.Id " +
                "WHERE c.parent_id IS NULL " +
                "ORDER BY c.created_at DESC";
        List<ProductComment> mainComments = jdbcTemplate.query(sql, new ProductCommentMapper());
        // Load replies cho mỗi comment chính
        for (ProductComment pc : mainComments) {
            pc.setReplies(findReplies(pc.getId()));
        }
        return mainComments;
    }

    @Override
    public void delete(int id) {
        jdbcTemplate.update("DELETE FROM tb_product_comments WHERE id=?", id);
    }

   
}
