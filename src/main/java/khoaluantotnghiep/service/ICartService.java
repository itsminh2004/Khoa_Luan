package khoaluantotnghiep.service;

import khoaluantotnghiep.model.CartItem;

import java.util.List;

public interface ICartService {
    List<CartItem> getItemsByUser(int userId);
    CartItem addItem(int userId, int productId, int quantity);
    CartItem updateQuantity(int cartItemId, int quantity);
    void removeItem(int cartItemId);
    void removeItem(int userId, int productId);
    void clearCart(int userId);
}


