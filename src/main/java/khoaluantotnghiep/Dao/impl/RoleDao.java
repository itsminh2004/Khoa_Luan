package khoaluantotnghiep.Dao.impl;

import khoaluantotnghiep.Dao.IRoleDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class RoleDao implements IRoleDao {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public List<String> getRolesByUserId(int userId) {
        String sql = "SELECT role FROM tb_roles WHERE user_id = ?";
        try {
            return jdbcTemplate.query(sql,
                    (rs, rowNum) -> rs.getString("role"), userId);
        } catch (Exception e) {
            e.printStackTrace();
            return new java.util.ArrayList<>();
        }
    }

    @Override
    public boolean assignRole(int userId, String role) {
        // Kiểm tra xem role đã tồn tại chưa
        if (hasRole(userId, role)) {
            return true; // Đã có role này rồi
        }

        String sql = "INSERT INTO tb_roles (user_id, role) VALUES (?, ?)";
        try {
            int rows = jdbcTemplate.update(sql, userId, role);
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean removeRole(int userId, String role) {
        String sql = "DELETE FROM tb_roles WHERE user_id = ? AND role = ?";
        try {
            int rows = jdbcTemplate.update(sql, userId, role);
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean removeAllRoles(int userId) {
        String sql = "DELETE FROM tb_roles WHERE user_id = ?";
        try {
            jdbcTemplate.update(sql, userId);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean hasRole(int userId, String role) {
        String sql = "SELECT COUNT(*) FROM tb_roles WHERE user_id = ? AND role = ?";
        try {
            Integer count = jdbcTemplate.queryForObject(sql, Integer.class, userId, role);
            return count != null && count > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
