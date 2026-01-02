package khoaluantotnghiep.service.impl;

import khoaluantotnghiep.Dao.ICartDao;
import khoaluantotnghiep.model.CartItem;
import khoaluantotnghiep.service.ICartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import java.util.List;

@Service
public class CartService implements ICartService {

    @Autowired
    private ICartDao cartDao;

    @Override
    public List<CartItem> getItemsByUser(int userId) {
        return cartDao.findByUserId(userId);
    }

    @Override
    public CartItem addItem(int userId, int productId, int quantity) {
        Assert.isTrue(quantity > 0, "Quantity must be positive");

        CartItem existing = cartDao.findByUserAndProduct(userId, productId);
        if (existing != null) {
            int newQuantity = existing.getQuantity() + quantity;
            return cartDao.updateQuantity(existing.getId(), newQuantity);
        }

        CartItem item = new CartItem();
        item.setUserId(userId);
        item.setProductId(productId);
        item.setQuantity(quantity);
        return cartDao.insert(item);
    }

    @Override
    public CartItem updateQuantity(int cartItemId, int quantity) {
        Assert.isTrue(quantity > 0, "Quantity must be positive");
        return cartDao.updateQuantity(cartItemId, quantity);
    }

    @Override
    public void removeItem(int cartItemId) {
        cartDao.delete(cartItemId);
    }

    @Override
    public void removeItem(int userId, int productId) {
        cartDao.deleteByUserAndProduct(userId, productId);
    }

    @Override
    public void clearCart(int userId) {
        cartDao.deleteByUser(userId);
    }
}


