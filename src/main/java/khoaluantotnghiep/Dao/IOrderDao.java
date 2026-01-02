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
}



