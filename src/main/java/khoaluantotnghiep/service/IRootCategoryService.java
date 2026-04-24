package khoaluantotnghiep.service;

import khoaluantotnghiep.model.RootCategory;
import java.util.List;

public interface IRootCategoryService {
    RootCategory save(RootCategory rootCategory);

    RootCategory update(RootCategory rootCategory);

    void delete(int id);

    RootCategory findOne(int id);

    List<RootCategory> findAll();

    List<RootCategory> findAllPaging(int offset, int limit);

    int countAll();
    void saveAll(List<RootCategory> items);
}
