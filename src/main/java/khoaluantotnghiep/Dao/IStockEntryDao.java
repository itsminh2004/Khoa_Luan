package khoaluantotnghiep.Dao;

import khoaluantotnghiep.model.StockEntry;
import java.util.List;

public interface IStockEntryDao {
    StockEntry insert(StockEntry entry);
    List<StockEntry> findAll();
    List<StockEntry> findByProductId(int productId);
}
