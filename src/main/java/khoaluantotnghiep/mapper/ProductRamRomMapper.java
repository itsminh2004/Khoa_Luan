package khoaluantotnghiep.mapper;

import khoaluantotnghiep.model.ProductRamRom;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ProductRamRomMapper implements RowMapper<ProductRamRom> {
    @Override
    public ProductRamRom mapRow(ResultSet rs, int rowNum) throws SQLException {
        ProductRamRom ramRom = new ProductRamRom();
        ramRom.setId(rs.getInt("id"));
        ramRom.setProductId(rs.getInt("product_id"));
        ramRom.setRam(rs.getString("ram"));
        ramRom.setRom(rs.getString("rom"));
        return ramRom;
    }
}

