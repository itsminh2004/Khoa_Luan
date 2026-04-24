package khoaluantotnghiep.Dao.impl;

import khoaluantotnghiep.Dao.IProductVariantNewDao;
import khoaluantotnghiep.Dao.IStockEntryDao;
import khoaluantotnghiep.mapper.StockEntryMapper;
import khoaluantotnghiep.model.StockEntry;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public class StockEntryDao implements IStockEntryDao {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Autowired
    private IProductVariantNewDao productVariantNewDao;

    @Override
    public StockEntry insert(StockEntry entry) {

        Integer vId = (entry.getVariantId() != null && entry.getVariantId() > 0) ? entry.getVariantId() : null;


        java.util.Date entryDate = entry.getEntryDate() != null ? entry.getEntryDate() : new java.util.Date();

        String sql = "INSERT INTO tb_stock_entry (product_id, variant_id, quantity, entry_price, supplier, entry_date, note) VALUES (?, ?, ?, ?, ?, ?, ?)";

        jdbcTemplate.update(sql,
                entry.getProductId(),
                vId,
                entry.getQuantity(),
                entry.getEntryPrice(),
                entry.getSupplier(),
                entryDate,
                entry.getNote()
        );


        if (vId != null) {
            jdbcTemplate.update("UPDATE tb_product_variants_new SET stock = stock + ? WHERE id = ?", entry.getQuantity(), vId);

            productVariantNewDao.syncProductStock(entry.getProductId());
        } else {
            jdbcTemplate.update("UPDATE tb_product SET stock = stock + ? WHERE id = ?", entry.getQuantity(), entry.getProductId());
        }

        return entry;
    }

    @Override
    public List<StockEntry> findAll() {
        String sql = "SELECT s.*, p.Name as ProductName, " +
                "CONCAT(c.color_name, ' | ', r.ram, 'GB/', r.rom, 'GB') as variant_name " +
                "FROM tb_stock_entry s " +
                "JOIN tb_product p ON s.product_id = p.Id " +
                "LEFT JOIN tb_product_variants_new v ON s.variant_id = v.id " +
                "LEFT JOIN tb_product_colors c ON v.color_id = c.id " +
                "LEFT JOIN tb_product_ram_roms r ON v.ram_rom_id = r.id " +
                "ORDER BY s.entry_date DESC";
        return jdbcTemplate.query(sql, new StockEntryMapper());
    }

    @Override
    public List<StockEntry> findByProductId(int productId) {
        String sql = "SELECT s.*, p.Name as ProductName, " +
                "CONCAT(c.color_name, ' | ', r.ram, 'GB/', r.rom, 'GB') as variant_name " +
                "FROM tb_stock_entry s " +
                "JOIN tb_product p ON s.product_id = p.Id " +
                "LEFT JOIN tb_product_variants_new v ON s.variant_id = v.id " +
                "LEFT JOIN tb_product_colors c ON v.color_id = c.id " +
                "LEFT JOIN tb_product_ram_roms r ON v.ram_rom_id = r.id " +
                "WHERE s.product_id = ? ORDER BY s.entry_date DESC";
        return jdbcTemplate.query(sql, new StockEntryMapper(), productId);
    }
}
