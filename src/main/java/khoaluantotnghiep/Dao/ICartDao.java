package khoaluantotnghiep.Dao;

import khoaluantotnghiep.model.CartItem;

import java.util.List;

public interface ICartDao {
    CartItem findById(int id);
    CartItem findByUserAndProduct(int userId, int productId);
    CartItem findByUserProductAndVariant(int userId, int productId, Integer variantId);
    List<CartItem> findByUserId(int userId);
    CartItem insert(CartItem item);
    CartItem updateQuantity(int id, int quantity);
    void delete(int id);
    void deleteByUser(int userId);
    void deleteByUserAndProduct(int userId, int productId);
}


