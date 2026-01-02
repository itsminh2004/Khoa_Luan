package khoaluantotnghiep.service.impl;

import khoaluantotnghiep.Dao.ISeriesDao;
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
}
