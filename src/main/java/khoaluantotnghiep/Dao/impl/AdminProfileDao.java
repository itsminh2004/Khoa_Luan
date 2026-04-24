package khoaluantotnghiep.Dao.impl;

import khoaluantotnghiep.Dao.IAdminProfileDao;
import khoaluantotnghiep.model.User;
import khoaluantotnghiep.model.UserAddress;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collections;
import java.util.List;

@Repository
public class AdminProfileDao implements IAdminProfileDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private User mapUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setEmail(rs.getString("email"));
        user.setFullName(rs.getString("full_name"));
        user.setEnabled(rs.getBoolean("enabled"));
        return user;
    }

    private UserAddress mapAddress(ResultSet rs) throws SQLException {
        UserAddress address = new UserAddress();
        address.setId(rs.getInt("id"));
        address.setUserId(rs.getInt("user_id"));
        address.setRecipientName(rs.getString("recipient_name"));
        address.setPhone(rs.getString("phone"));
        address.setProvince(rs.getString("province"));
        address.setDistrict(rs.getString("district"));
        address.setWard(rs.getString("ward"));
        address.setSpecificAddress(rs.getString("specific_address"));
        address.setDefault(rs.getBoolean("is_default"));
        address.setCreatedAt(rs.getTimestamp("created_at"));
        return address;
    }

    @Override
    public User getUserById(int userId) {
        String sqlUser = "SELECT * FROM tb_users WHERE id = ?";
        String sqlRoles = "SELECT role FROM tb_roles WHERE user_id = ?";

        try {
            User user = jdbcTemplate.queryForObject(sqlUser, (rs, rowNum) -> mapUser(rs), userId);

            List<String> roles = jdbcTemplate.query(sqlRoles, (rs, rowNum) -> rs.getString("role"), userId);
            user.setRoles(roles.isEmpty() ? Collections.singletonList("USER") : roles);

            return user;
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public UserAddress getUserAddressByUserId(int userId) {
        // Ưu tiên address mặc định (is_default = 1), nếu không có thì lấy gần nhất.
        String sqlDefault =
                "SELECT * FROM tb_user_address " +
                        "WHERE user_id = ? AND is_default = 1 " +
                        "ORDER BY created_at DESC LIMIT 1";

        String sqlFallback =
                "SELECT * FROM tb_user_address " +
                        "WHERE user_id = ? " +
                        "ORDER BY is_default DESC, created_at DESC LIMIT 1";

        try {
            return jdbcTemplate.queryForObject(sqlDefault, (rs, rowNum) -> mapAddress(rs), userId);
        } catch (Exception ignored) {
            // fallback
        }

        try {
            return jdbcTemplate.queryForObject(sqlFallback, (rs, rowNum) -> mapAddress(rs), userId);
        } catch (Exception ignored) {
            return null;
        }
    }

    @Override
    public boolean updateUser(int userId, String fullName, String email, UserAddress address) {
        // Update tb_users
        String sqlUpdateUser = "UPDATE tb_users SET full_name = ?, email = ? WHERE id = ?";
        int updatedUserRows = jdbcTemplate.update(sqlUpdateUser, fullName, email, userId);

        // Update tb_user_address (ưu tiên address mặc định)
        String sqlFindDefaultAddressId =
                "SELECT id FROM tb_user_address WHERE user_id = ? AND is_default = 1 LIMIT 1";
        String sqlFindAnyAddressId =
                "SELECT id FROM tb_user_address WHERE user_id = ? ORDER BY is_default DESC, created_at DESC LIMIT 1";

        Integer defaultAddressId = null;
        try {
            defaultAddressId = jdbcTemplate.queryForObject(sqlFindDefaultAddressId, Integer.class, userId);
        } catch (Exception ignored) {
            // no default
        }

        int updatedAddressRows = 0;

        if (defaultAddressId != null) {
            String sqlUpdateAddress =
                    "UPDATE tb_user_address SET " +
                            "phone = ?, province = ?, district = ?, ward = ?, specific_address = ?, is_default = 1 " +
                            "WHERE id = ?";
            updatedAddressRows = jdbcTemplate.update(
                    sqlUpdateAddress,
                    address.getPhone(),
                    address.getProvince(),
                    address.getDistrict(),
                    address.getWard(),
                    address.getSpecificAddress(),
                    defaultAddressId
            );
        } else {
            // Không có address mặc định: lấy address bất kỳ để cập nhật rồi chuyển thành mặc định,
            // hoặc insert nếu chưa có address nào.
            Integer anyAddressId = null;
            try {
                anyAddressId = jdbcTemplate.queryForObject(sqlFindAnyAddressId, Integer.class, userId);
            } catch (Exception ignored) {
                // no address
            }

            if (anyAddressId != null) {
                jdbcTemplate.update("UPDATE tb_user_address SET is_default = 0 WHERE user_id = ?", userId);

                String sqlUpdateAddress =
                        "UPDATE tb_user_address SET " +
                                "phone = ?, province = ?, district = ?, ward = ?, specific_address = ?, is_default = 1 " +
                                "WHERE id = ?";
                updatedAddressRows = jdbcTemplate.update(
                        sqlUpdateAddress,
                        address.getPhone(),
                        address.getProvince(),
                        address.getDistrict(),
                        address.getWard(),
                        address.getSpecificAddress(),
                        anyAddressId
                );
            } else {
                // Insert new address và set làm mặc định.
                String sqlInsertAddress =
                        "INSERT INTO tb_user_address " +
                                "(user_id, recipient_name, phone, province, district, ward, specific_address, is_default) " +
                                "VALUES (?, ?, ?, ?, ?, ?, ?, 1)";

                updatedAddressRows = jdbcTemplate.update(
                        sqlInsertAddress,
                        userId,
                        address.getRecipientName(),
                        address.getPhone(),
                        address.getProvince(),
                        address.getDistrict(),
                        address.getWard(),
                        address.getSpecificAddress()
                );
            }
        }

        return updatedUserRows > 0 && updatedAddressRows > 0;
    }
}

