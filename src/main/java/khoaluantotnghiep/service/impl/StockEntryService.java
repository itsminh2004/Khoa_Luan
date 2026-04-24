package khoaluantotnghiep.service.impl;

import khoaluantotnghiep.Dao.IStockEntryDao;
import khoaluantotnghiep.model.StockEntry;
import khoaluantotnghiep.service.IStockEntryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class StockEntryService implements IStockEntryService {
    @Autowired
    private IStockEntryDao stockEntryDao;

    @Override
    public StockEntry save(StockEntry entry) {
        return stockEntryDao.insert(entry);
    }

    @Override
    public List<StockEntry> findAll() {
        return stockEntryDao.findAll();
    }
}
