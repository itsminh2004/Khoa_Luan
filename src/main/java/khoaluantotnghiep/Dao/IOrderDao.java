package khoaluantotnghiep.Dao;

import khoaluantotnghiep.model.Order;
import khoaluantotnghiep.model.OrderItem;

import java.util.List;

public interface IOrderDao {
    Order findById(int id);

    List<Order> findByUserId(int userId);

    List<Order> findAll();

    Order insert(Order order);

    void update(Order order);

    void updateStatus(int orderId, String status);

    void delete(int id);

    // OrderItem methods
    List<OrderItem> findItemsByOrderId(int orderId);

    OrderItem insertItem(OrderItem item);

    void deleteItemsByOrderId(int orderId);

    // Statistics methods
    long getTotalOrders();

    double getMonthlyRevenue(int year, int month);

    double getTotalRevenue();

    List<java.util.Map<String, Object>> getTopSellingProducts(int limit);

    List<java.util.Map<String, Object>> getTopSellingProductsByMonth(int year, int month, int limit);

    List<java.util.Map<String, Object>> getDailyRevenue(int days);

    // Get all products sold in a specific month with quantity and revenue
    List<java.util.Map<String, Object>> getProductsSalesByMonth(int year, int month);

    // Get daily revenue for a specific month
    List<java.util.Map<String, Object>> getDailyRevenueByMonth(int year, int month);
}
