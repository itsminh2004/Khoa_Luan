package khoaluantotnghiep.service;

import khoaluantotnghiep.model.Order;

import java.util.List;

public interface IOrderService {
    Order createOrder(Order order);

    Order findById(int id);

    List<Order> findByUserId(int userId);

    List<Order> findAll();

    void updateOrder(Order order);

    void updateStatus(int orderId, String status);

    void deleteOrder(int id);

    // Statistics methods
    long getTotalOrders();

    double getMonthlyRevenue(int year, int month);

    double getTotalRevenue();

    List<java.util.Map<String, Object>> getTopSellingProducts(int limit);

    List<java.util.Map<String, Object>> getTopSellingProductsByMonth(int year, int month, int limit);

    List<java.util.Map<String, Object>> getDailyRevenue(int days);

    List<java.util.Map<String, Object>> getProductsSalesByMonth(int year, int month);

    List<java.util.Map<String, Object>> getDailyRevenueByMonth(int year, int month);
}
