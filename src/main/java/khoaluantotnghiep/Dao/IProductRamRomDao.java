package khoaluantotnghiep.Dao;

import khoaluantotnghiep.model.ProductRamRom;

import java.util.List;

public interface IProductRamRomDao {
    ProductRamRom save(ProductRamRom ramRom);
    ProductRamRom update(ProductRamRom ramRom);
    void delete(int id);
    List<ProductRamRom> findByProductId(int productId);
    ProductRamRom findById(int id);
}

