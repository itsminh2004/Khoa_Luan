package khoaluantotnghiep.Dao;

import khoaluantotnghiep.model.Banner;

import java.util.List;

public interface IBannerDao {
    Banner save(Banner banner);

    Banner update(Banner banner);

    void delete(int id);

    Banner findOne(int id);

    List<Banner> findAllWithProduct(String position, Boolean active);

    default List<Banner> findAllWithProduct() {
        return findAllWithProduct(null, null);
    }
    List<Banner> findActive(String position);

    boolean toggleActive(int id);
}
