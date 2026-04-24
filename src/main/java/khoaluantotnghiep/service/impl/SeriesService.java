package khoaluantotnghiep.service.impl;

import khoaluantotnghiep.Dao.IProductCategory;
import khoaluantotnghiep.Dao.ISeriesDao;
import khoaluantotnghiep.Dao.impl.SeriesDao;
import khoaluantotnghiep.model.Series;
import khoaluantotnghiep.service.ISeriesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;

@Service
public class SeriesService implements ISeriesService {
    @Autowired
    private ISeriesDao seriesDao;
    @Autowired
    private IProductCategory productCategoryDao;

    @Override
    public Series findOne(int id) {
        return seriesDao.findOne(id);
    }

    @Override
    public List<Series> findAll() {
        return seriesDao.findAll();
    }

    @Override
    public List<Series> findByCategoryId(int categoryId) {
        List<Series> list = seriesDao.findByCategoryId(categoryId);
        return list != null ? list : Collections.emptyList();
    }

    @Override
    public Series insert(Series series) {
        return seriesDao.insert(series);
    }

    @Override
    public Series update(Series series) {
        return seriesDao.update(series);
    }

    @Override
    public void delete(int id) {
        seriesDao.delete(id);
    }

    @Override
    public void saveAll(List<Series> items) {
        List<khoaluantotnghiep.model.ProductCategory> cats = productCategoryDao.findAll();
        for (Series item : items) {
            if (item.getCategoryName() != null && !item.getCategoryName().isEmpty()) {
                for (khoaluantotnghiep.model.ProductCategory cat : cats) {
                    if (cat.getName().equalsIgnoreCase(item.getCategoryName())) {
                        item.setCategoryId(cat.getId());
                        break;
                    }
                }
            }
            seriesDao.insert(item);
        }
    }
}
