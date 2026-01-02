package khoaluantotnghiep.service;

import khoaluantotnghiep.model.WishlistItem;

import java.util.List;

public interface IWishlistService {
    List<WishlistItem> getItemsByUser(int userId);
    WishlistItem addItem(int userId, int productId);
    void removeItem(int wishlistItemId);
    void removeItem(int userId, int productId);
}


