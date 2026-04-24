package khoaluantotnghiep.Dao.impl;

import khoaluantotnghiep.Dao.IBannerDao;
import khoaluantotnghiep.model.Banner;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Repository
public class BannerDao implements IBannerDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private Banner mapRow(java.sql.ResultSet rs) {
        try {
            Banner b = new Banner();
            b.setId(rs.getInt("id"));
            b.setTitle(rs.getString("title"));
            b.setImageUrl(rs.getString("image_url"));

            Object productIdObj = rs.getObject("product_id");
            b.setProductId(productIdObj == null ? null : ((Number) productIdObj).intValue());

            b.setPosition(rs.getString("position"));
            b.setSortOrder(rs.getInt("sort_order"));

            Timestamp startTs = rs.getTimestamp("start_date");
            b.setStartDate(startTs == null ? null : new Date(startTs.getTime()));

            Timestamp endTs = rs.getTimestamp("end_date");
            b.setEndDate(endTs == null ? null : new Date(endTs.getTime()));

            b.setActive(rs.getBoolean("active"));

            Timestamp createdTs = rs.getTimestamp("created_at");
            b.setCreatedAt(createdTs == null ? null : new Date(createdTs.getTime()));

            b.setProductName(rs.getString("productName"));
            return b;
        } catch (Exception e) {
            throw new RuntimeException("Failed to map Banner row", e);
        }
    }

    @Override
    public Banner save(Banner banner) {
        String sql = "INSERT INTO tb_banners (title, image_url, product_id, position, sort_order, start_date, end_date, active) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        KeyHolder keyHolder = new GeneratedKeyHolder();
        jdbcTemplate.update((Connection con) -> {
            PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            ps.setString(1, banner.getTitle());
            ps.setString(2, banner.getImageUrl());
            if (banner.getProductId() == null) {
                ps.setObject(3, null);
            } else {
                ps.setInt(3, banner.getProductId());
            }
            ps.setString(4, banner.getPosition());
            ps.setInt(5, banner.getSortOrder());

            if (banner.getStartDate() == null) {
                ps.setObject(6, null);
            } else {
                ps.setTimestamp(6, new Timestamp(banner.getStartDate().getTime()));
            }
            if (banner.getEndDate() == null) {
                ps.setObject(7, null);
            } else {
                ps.setTimestamp(7, new Timestamp(banner.getEndDate().getTime()));
            }

            ps.setBoolean(8, banner.isActive());
            return ps;
        }, keyHolder);

        if (keyHolder.getKey() != null) {
            banner.setId(keyHolder.getKey().intValue());
        }
        return banner;
    }

    @Override
    public Banner update(Banner banner) {
        String sql = "UPDATE tb_banners " +
                "SET title=?, image_url=?, product_id=?, position=?, sort_order=?, start_date=?, end_date=?, active=? " +
                "WHERE id=?";

        Integer productId = banner.getProductId();

        int row = jdbcTemplate.update(sql,
                banner.getTitle(),
                banner.getImageUrl(),
                productId,
                banner.getPosition(),
                banner.getSortOrder(),
                banner.getStartDate() == null ? null : new Timestamp(banner.getStartDate().getTime()),
                banner.getEndDate() == null ? null : new Timestamp(banner.getEndDate().getTime()),
                banner.isActive(),
                banner.getId());

        if (row == 0) {
            throw new RuntimeException("Banner not found for update. id=" + banner.getId());
        }

        return banner;
    }

    @Override
    public void delete(int id) {
        jdbcTemplate.update("DELETE FROM tb_banners WHERE id=?", id);
    }

    @Override
    public Banner findOne(int id) {
        String sql = "SELECT b.*, p.Name AS productName " +
                "FROM tb_banners b " +
                "LEFT JOIN tb_product p ON b.product_id = p.Id " +
                "WHERE b.id=?";

        try {
            return jdbcTemplate.queryForObject(sql, (rs, rowNum) -> mapRow(rs), id);
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    @Override
    public List<Banner> findAllWithProduct(String position, Boolean active) {
        StringBuilder sql = new StringBuilder(
                "SELECT b.*, p.Name AS productName " +
                        "FROM tb_banners b " +
                        "LEFT JOIN tb_product p ON b.product_id = p.Id " +
                        "WHERE 1=1");

        List<Object> params = new ArrayList<>();

        if (position != null && !position.trim().isEmpty()) {
            sql.append(" AND b.position=?");
            params.add(position);
        }

        if (active != null) {
            sql.append(" AND b.active=?");
            params.add(active);
        }

        sql.append(" ORDER BY b.sort_order ASC, b.id DESC");

        return jdbcTemplate.query(sql.toString(), params.toArray(), (rs, rowNum) -> mapRow(rs));
    }

    @Override
    public List<Banner> findActive(String position) {
        String sql = "SELECT b.*, p.Name AS productName " +
                "FROM tb_banners b " +
                "LEFT JOIN tb_product p ON b.product_id = p.Id " +
                "WHERE b.active=1 " +
                "AND b.position=? " +
                "AND (b.start_date IS NULL OR b.start_date <= NOW()) " +
                "AND (b.end_date IS NULL OR b.end_date >= NOW()) " +
                "ORDER BY b.sort_order ASC, b.id DESC";

        return jdbcTemplate.query(sql, new Object[]{position}, (rs, rowNum) -> mapRow(rs));
    }

    @Override
    public boolean toggleActive(int id) {
        Boolean current;
        try {
            // Thay Integer.class bằng Boolean.class để an toàn hơn
            current = jdbcTemplate.queryForObject("SELECT active FROM tb_banners WHERE id=?", Boolean.class, id);
        } catch (EmptyResultDataAccessException e) {
            throw new RuntimeException("Banner không tồn tại với id=" + id);
        }
        // Đảo ngược trạng thái: nếu đang null hoặc false thì thành true, ngược lại thành false
        boolean newActive = (current == null) ? true : !current;
        jdbcTemplate.update("UPDATE tb_banners SET active=? WHERE id=?", newActive, id);
        return newActive;
    }
}



