package khoaluantotnghiep.Dao.impl;

import khoaluantotnghiep.Dao.IUserAddressDao;
import khoaluantotnghiep.model.UserAddress;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class UserAddressDao implements IUserAddressDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private final RowMapper<UserAddress> rowMapper = new RowMapper<UserAddress>() {
        @Override
        public UserAddress mapRow(ResultSet rs, int rowNum) throws SQLException {
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
    };

    @Override
    public List<UserAddress> findByUserId(int userId) {
        String sql = "SELECT * FROM tb_user_address WHERE user_id = ? ORDER BY is_default DESC, created_at DESC";
        return jdbcTemplate.query(sql, new Object[]{userId}, rowMapper);
    }

    @Override
    public UserAddress findById(int id) {
        String sql = "SELECT * FROM tb_user_address WHERE id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new Object[]{id}, rowMapper);
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public int create(UserAddress address) {
        String sql = "INSERT INTO tb_user_address (user_id, recipient_name, phone, province, district, ward, specific_address, is_default) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        return jdbcTemplate.update(sql,
                address.getUserId(),
                address.getRecipientName(),
                address.getPhone(),
                address.getProvince(),
                address.getDistrict(),
                address.getWard(),
                address.getSpecificAddress(),
                address.isDefault() ? 1 : 0
        );
    }

    @Override
    public boolean update(UserAddress address) {
        String sql = "UPDATE tb_user_address SET recipient_name = ?, phone = ?, province = ?, district = ?, ward = ?, specific_address = ?, is_default = ? WHERE id = ?";
        int rows = jdbcTemplate.update(sql,
                address.getRecipientName(),
                address.getPhone(),
                address.getProvince(),
                address.getDistrict(),
                address.getWard(),
                address.getSpecificAddress(),
                address.isDefault() ? 1 : 0,
                address.getId()
        );
        return rows > 0;
    }

    @Override
    public boolean delete(int id) {
        String sql = "DELETE FROM tb_user_address WHERE id = ?";
        int rows = jdbcTemplate.update(sql, id);
        return rows > 0;
    }

    @Override
    public void resetDefault(int userId) {
        String sql = "UPDATE tb_user_address SET is_default = 0 WHERE user_id = ?";
        jdbcTemplate.update(sql, userId);
    }
}
