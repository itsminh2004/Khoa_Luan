package khoaluantotnghiep.mapper;

import khoaluantotnghiep.model.StockEntry;
import org.springframework.jdbc.core.RowMapper;
import java.sql.ResultSet;
import java.sql.SQLException;

public class StockEntryMapper implements RowMapper<StockEntry> {
    @Override
    public StockEntry mapRow(ResultSet rs, int rowNum) throws SQLException {
        StockEntry s = new StockEntry();
        s.setId(rs.getInt("id"));
        s.setProductId(rs.getInt("product_id"));
        s.setVariantId(rs.getObject("variant_id") != null ? rs.getInt("variant_id") : null);
        s.setQuantity(rs.getInt("quantity"));
        s.setEntryPrice(rs.getDouble("entry_price"));
        s.setSupplier(rs.getString("supplier"));
        s.setEntryDate(rs.getTimestamp("entry_date"));
        s.setNote(rs.getString("note"));
        try { s.setProductName(rs.getString("ProductName")); } catch (Exception e) {}
        try { s.setVariantName(rs.getString("variant_name")); } catch (Exception e) {}
        return s;
    }
}
