package khoaluantotnghiep.Dao;

import khoaluantotnghiep.model.Series;

import java.util.List;

public interface ISeriesDao {
    Series findOne(int id);
    List<Series> findAll();
    List<Series> findByCategoryId(int categoryId);
    Series insert(Series series);
    Series update(Series series);
    void delete(int id);
}
