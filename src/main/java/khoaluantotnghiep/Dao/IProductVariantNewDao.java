package khoaluantotnghiep.Dao;

import khoaluantotnghiep.model.ProductVariantNew;

import java.util.List;

public interface IProductVariantNewDao {
    ProductVariantNew save(ProductVariantNew variant);
    ProductVariantNew update(ProductVariantNew variant);
    void delete(int id);
    List<ProductVariantNew> findByProductId(int productId);
    ProductVariantNew findById(int id);
    ProductVariantNew findByColorIdAndRamRomId(int colorId, int ramRomId);
    List<ProductVariantNew> findByColorId(int colorId);
    void deleteByColorId(int colorId);
}


