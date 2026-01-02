package khoaluantotnghiep.service.impl;

import khoaluantotnghiep.Dao.IOrderDao;
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

    @Override
    @Transactional
    public Order createOrder(Order order) {
        // Set default status if not provided
        if (order.getStatus() == null || order.getStatus().isEmpty()) {
            order.setStatus("PENDING");
        }

        // Insert order
        Order savedOrder = orderDao.insert(order);

        // Insert order items
        if (order.getItems() != null && !order.getItems().isEmpty()) {
            for (OrderItem item : order.getItems()) {
                item.setOrderId(savedOrder.getId());
                orderDao.insertItem(item);
            }
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
}



