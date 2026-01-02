package khoaluantotnghiep.mapper;

import khoaluantotnghiep.model.Product;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

public class ProductMapper implements RowMapper<Product> {
    @Override
    public Product mapRow(ResultSet rs, int rowNum) throws SQLException {
        Product p = new Product();

        p.setId(rs.getInt("Id"));
        p.setName(rs.getString("Name"));
        p.setDescription(rs.getString("Description"));
        p.setPrice(rs.getDouble("Price"));
        p.setPriceSale(rs.getDouble("PriceSale"));
        p.setStock(rs.getInt("Stock"));
        Timestamp created = rs.getTimestamp("CreatedDate");
        if (created != null) {
            p.setCreatedDate(new Timestamp(created.getTime()));
        }
        p.setActive(rs.getBoolean("Active"));
        p.setCategoryId(rs.getInt("CategoryId"));
        p.setSeriesId(rs.getInt("SeriesId"));
        p.setAlias(rs.getString("Alias"));
        p.setImage(rs.getString("Image"));
        try { p.setHasVariants(rs.getBoolean("has_variants")); } catch (SQLException e) { /* ignore */ }
        try { p.setDefaultRam(rs.getString("default_ram")); } catch (SQLException e) { /* ignore */ }
        try { p.setDefaultRom(rs.getString("default_rom")); } catch (SQLException e) { /* ignore */ }

        try {
            p.setCategoryName(rs.getString("CategoryName"));
        } catch (SQLException e) {
            p.setCategoryName(null);
        }

        try {
            p.setSeriesName(rs.getString("SeriesName"));
        } catch (SQLException e) {
            p.setSeriesName(null);
        }

        return p;
    }
}
