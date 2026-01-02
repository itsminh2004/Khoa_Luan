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
}



