package khoaluantotnghiep.Dao.impl;

import khoaluantotnghiep.Dao.IUserDao;
import khoaluantotnghiep.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Repository
public class UserDao implements IUserDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;  // ✅ Sử dụng JdbcTemplate từ Spring configuration

    @Override
    public User login(String email, String password) {
        String sql = "SELECT u.*, r.role FROM tb_users u " +
                "LEFT JOIN tb_roles r ON u.id = r.user_id " +
                "WHERE u.email = ? AND u.password = ? AND u.enabled = 1";
        try {
            List<User> users = new ArrayList<>();
            jdbcTemplate.query(sql, new Object[]{email, password}, (rs) -> {
                int userId = rs.getInt("id");
                User user = users.stream()
                        .filter(u -> u.getId() == userId)
                        .findFirst()
                        .orElse(null);

                if (user == null) {
                    user = new User();
                    user.setId(userId);
                    user.setEmail(rs.getString("email"));
                    user.setFullName(rs.getString("full_name"));
                    user.setEnabled(rs.getBoolean("enabled"));
                    user.setRoles(new ArrayList<>());
                    users.add(user);
                }

                String role = rs.getString("role");
                if (role != null && !user.getRoles().contains(role)) {
                    user.getRoles().add(role);
                }
            });

            if (!users.isEmpty()) {
                User user = users.get(0);
                if (user.getRoles().isEmpty()) {
                    user.setRoles(Collections.singletonList("USER"));
                }
                return user;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public User findByEmail(String email) {
        String sql = "SELECT * FROM tb_users WHERE email = ?";
        String sqlRoles = "SELECT role FROM tb_roles WHERE user_id = ?";
        try {
            User user = jdbcTemplate.queryForObject(sql, new Object[]{email}, (rs, rowNum) -> {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setEmail(rs.getString("email"));
                u.setPassword(rs.getString("password"));
                u.setFullName(rs.getString("full_name"));
                u.setEnabled(rs.getBoolean("enabled"));
                return u;
            });

            if (user != null) {
                List<String> roles = jdbcTemplate.query(sqlRoles, new Object[]{user.getId()},
                        (rs, rowNum) -> rs.getString("role"));
                user.setRoles(roles.isEmpty() ? Collections.singletonList("USER") : roles);
            }

            return user;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean saveVerificationCode(String email, String code) {
        String sql = "UPDATE tb_users SET verification_code = ? WHERE email = ?";
        try {
            int rows = jdbcTemplate.update(sql, code, email);
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public User verifyOTP(String email, String code) {
        String sqlSelect = "SELECT * FROM tb_users WHERE email = ? AND verification_code = ?";
        String sqlUpdate = "UPDATE tb_users SET enabled = 1, verification_code = NULL WHERE id = ?";
        String sqlRole = "SELECT role FROM tb_roles WHERE user_id = ?";
        String sqlInsertRole = "INSERT INTO tb_roles (user_id, role) VALUES (?, 'USER')";

        try {
            User user = jdbcTemplate.queryForObject(sqlSelect, new Object[]{email, code},
                    (rs, rowNum) -> {
                        User u = new User();
                        u.setId(rs.getInt("id"));
                        u.setEmail(rs.getString("email"));
                        u.setFullName(rs.getString("full_name"));
                        u.setEnabled(false);
                        return u;
                    });

            if (user != null) {
                System.out.println("[DEBUG] Xac thuc OTP - userId: " + user.getId());
                int updateResult = jdbcTemplate.update(sqlUpdate, user.getId());
                System.out.println("[DEBUG] Ket qua update enabled: " + updateResult);

                List<String> roles = jdbcTemplate.query(sqlRole, new Object[]{user.getId()},
                        (rs, rowNum) -> rs.getString("role"));

                if (roles.isEmpty()) {
                    jdbcTemplate.update(sqlInsertRole, user.getId());
                    roles.add("USER");
                }

                user.setRoles(roles);
                user.setEnabled(true);
                return user;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean register(String email, String fullName, String password) {
        String sql = "INSERT INTO tb_users (email, full_name, password, enabled) VALUES (?, ?, ?, 1)";
        try {
            int rows = jdbcTemplate.update(sql, email, fullName, password);
            if (rows > 0) {
                // Lấy userId vừa insert
                String sqlGetId = "SELECT id FROM tb_users WHERE email = ?";
                Integer userId = jdbcTemplate.queryForObject(sqlGetId, new Object[]{email}, Integer.class);

                if (userId != null) {
                    String sqlRole = "INSERT INTO tb_roles (user_id, role) VALUES (?, 'USER')";
                    jdbcTemplate.update(sqlRole, userId);
                }
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public List<User> findAllUsers() {
        String sql = "SELECT * FROM tb_users WHERE enabled = 1";
        try {
            return jdbcTemplate.query(sql, (rs, rowNum) -> {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setEmail(rs.getString("email"));
                user.setFullName(rs.getString("full_name"));
                user.setEnabled(rs.getBoolean("enabled"));

                // Load roles
                String sqlRoles = "SELECT role FROM tb_roles WHERE user_id = ?";
                List<String> roles = jdbcTemplate.query(sqlRoles, new Object[]{user.getId()},
                        (rs2, rowNum2) -> rs2.getString("role"));
                user.setRoles(roles.isEmpty() ? Collections.singletonList("USER") : roles);

                return user;
            });
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    @Override
    public void updateUser(int userId, String role) {
        String sql = "UPDATE tb_users SET role = ? WHERE id = ?";
        try {
            jdbcTemplate.update(sql, role, userId);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteUser(int userId) {
        String sql = "DELETE FROM tb_users WHERE id = ?";
        jdbcTemplate.update(sql, userId);
    }

    @Override
    public User findOne(int id) {
        String sql = "SELECT * FROM tb_users WHERE id = ?";
        try {
            User user = jdbcTemplate.queryForObject(sql, new Object[]{id}, (rs, rowNum) -> {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setEmail(rs.getString("email"));
                u.setFullName(rs.getString("full_name"));
                u.setEnabled(rs.getBoolean("enabled"));
                return u;
            });

            if (user != null) {
                String sqlRoles = "SELECT role FROM tb_roles WHERE user_id = ?";
                List<String> roles = jdbcTemplate.query(sqlRoles, new Object[]{user.getId()},
                        (rs, rowNum) -> rs.getString("role"));
                user.setRoles(roles.isEmpty() ? Collections.singletonList("USER") : roles);
            }

            return user;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean updatePassword(String email, String newPassword) {
        String sql = "UPDATE tb_users SET password = ? WHERE email = ?";
        try {
            int rows = jdbcTemplate.update(sql, newPassword, email);
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean verifyResetCode(String email, String code) {
        String sql = "SELECT COUNT(*) FROM tb_users WHERE email = ? AND verification_code = ?";
        try {
            Integer count = jdbcTemplate.queryForObject(sql, new Object[]{email, code}, Integer.class);
            return count != null && count > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean updatePasswordAndClearCode(String email, String newPassword) {
        String sql = "UPDATE tb_users SET password = ?, verification_code = NULL WHERE email = ?";
        try {
            int rowsAffected = jdbcTemplate.update(sql, newPassword, email);
            System.out.println("[DEBUG] Update password for email: " + email + ", rows affected: " + rowsAffected);
            return rowsAffected > 0;
        } catch (Exception e) {
            System.err.println("[ERROR] Failed to update password: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
}