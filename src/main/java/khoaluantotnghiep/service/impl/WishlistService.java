package khoaluantotnghiep.service.impl;

import khoaluantotnghiep.Dao.IWishlistDao;
import khoaluantotnghiep.model.WishlistItem;
import khoaluantotnghiep.service.IWishlistService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class WishlistService implements IWishlistService {

    @Autowired
    private IWishlistDao wishlistDao;

    @Override
    public List<WishlistItem> getItemsByUser(int userId) {
        return wishlistDao.findByUserId(userId);
    }

    @Override
    public WishlistItem addItem(int userId, int productId) {
        WishlistItem existing = wishlistDao.findByUserAndProduct(userId, productId);
        if (existing != null) {
            return existing;
        }
        WishlistItem item = new WishlistItem();
        item.setUserId(userId);
        item.setProductId(productId);
        return wishlistDao.insert(item);
    }

    @Override
    public void removeItem(int wishlistItemId) {
        wishlistDao.delete(wishlistItemId);
    }

    @Override
    public void removeItem(int userId, int productId) {
        wishlistDao.deleteByUserAndProduct(userId, productId);
    }
}


