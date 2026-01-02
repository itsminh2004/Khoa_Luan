package khoaluantotnghiep.Dao;

import khoaluantotnghiep.model.WishlistItem;

import java.util.List;

public interface IWishlistDao {
    WishlistItem findById(int id);
    WishlistItem findByUserAndProduct(int userId, int productId);
    List<WishlistItem> findByUserId(int userId);
    WishlistItem insert(WishlistItem item);
    void delete(int id);
    void deleteByUserAndProduct(int userId, int productId);
}


