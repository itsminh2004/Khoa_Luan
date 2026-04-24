package khoaluantotnghiep.service;

import khoaluantotnghiep.model.StockEntry;
import java.util.List;

public interface IStockEntryService {
    StockEntry save(StockEntry entry);
    List<StockEntry> findAll();
}
