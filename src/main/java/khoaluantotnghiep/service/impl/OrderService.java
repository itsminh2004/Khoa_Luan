package khoaluantotnghiep.service.impl;

import khoaluantotnghiep.Dao.IOrderDao;
import khoaluantotnghiep.Dao.IProductDao;
import khoaluantotnghiep.Dao.IProductVariantNewDao;
import khoaluantotnghiep.model.Order;
import khoaluantotnghiep.model.OrderItem;
import khoaluantotnghiep.service.IOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class OrderService implements IOrderService {

    @Autowired
    private IOrderDao orderDao;

    @Autowired
    private IProductDao productDao;

    @Autowired
    private IProductVariantNewDao variantDao;

    @Autowired
    private khoaluantotnghiep.Dao.ICouponDao couponDao;

    @Override
    @Transactional
    public Order createOrder(Order order) {
        // Set default status if not provided
        if (order.getStatus() == null || order.getStatus().isEmpty()) {
            order.setStatus("PENDING");
        }

        // Insert order
        Order savedOrder = orderDao.insert(order);

        // Insert order items and reduce stock
        if (order.getItems() != null && !order.getItems().isEmpty()) {
            for (OrderItem item : order.getItems()) {
                item.setOrderId(savedOrder.getId());
                orderDao.insertItem(item);

                // Reduce stock
                if (item.getVariantId() != null && item.getVariantId() > 0) {
                    variantDao.reduceStock(item.getVariantId(), item.getQuantity());
                } else {
                    productDao.reduceStock(item.getProductId(), item.getQuantity());
                }
            }
        }

        // Increment coupon used count
        if (order.getCouponId() != null) {
            couponDao.incrementUsedCount(order.getCouponId());
        }

        // Return order with items
        return orderDao.findById(savedOrder.getId());
    }

    @Override
    public Order findById(int id) {
        return orderDao.findById(id);
    }

    @Override
    public List<Order> findByUserId(int userId) {
        return orderDao.findByUserId(userId);
    }

    @Override
    public List<Order> findAll() {
        return orderDao.findAll();
    }

    @Override
    @Transactional
    public void updateStatus(int orderId, String status) {
        orderDao.updateStatus(orderId, status);
    }

    @Override
    public void updateOrder(Order order) {
        orderDao.update(order);
    }

    @Override
    @Transactional
    public void deleteOrder(int id) {
        orderDao.delete(id);
    }

    @Override
    public long getTotalOrders() {
        return orderDao.getTotalOrders();
    }

    @Override
    public double getMonthlyRevenue(int year, int month) {
        return orderDao.getMonthlyRevenue(year, month);
    }

    @Override
    public double getTotalRevenue() {
        return orderDao.getTotalRevenue();
    }

    @Override
    public List<java.util.Map<String, Object>> getTopSellingProducts(int limit) {
        return orderDao.getTopSellingProducts(limit);
    }

    @Override
    public List<java.util.Map<String, Object>> getTopSellingProductsByMonth(int year, int month, int limit) {
        return orderDao.getTopSellingProductsByMonth(year, month, limit);
    }

    @Override
    public List<java.util.Map<String, Object>> getDailyRevenue(int days) {
        return orderDao.getDailyRevenue(days);
    }

    @Override
    public List<java.util.Map<String, Object>> getProductsSalesByMonth(int year, int month) {
        return orderDao.getProductsSalesByMonth(year, month);
    }

    @Override
    public List<java.util.Map<String, Object>> getDailyRevenueByMonth(int year, int month) {
        return orderDao.getDailyRevenueByMonth(year, month);
    }
}
