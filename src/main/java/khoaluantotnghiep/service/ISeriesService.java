package khoaluantotnghiep.service;

import khoaluantotnghiep.model.Series;

import java.util.List;

public interface ISeriesService {
    Series findOne(int id);
    List<Series> findAll();
    List<Series> findByCategoryId(int categoryId);
    Series insert(Series series);
    Series update(Series series);
    void delete(int id);
}
