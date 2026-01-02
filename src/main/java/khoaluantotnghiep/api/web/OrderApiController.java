package khoaluantotnghiep.api.web;

import khoaluantotnghiep.dto.*;
import khoaluantotnghiep.model.Order;
import khoaluantotnghiep.model.OrderItem;
import khoaluantotnghiep.model.Product;
import khoaluantotnghiep.service.ICartService;
import khoaluantotnghiep.service.IOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@CrossOrigin(origins = {"http://127.0.0.1:5500", "http://localhost:5500"})
@RestController
@RequestMapping("/api/orders")
public class OrderApiController {

    @Autowired
    private IOrderService orderService;

    @Autowired
    private ICartService cartService;

    @PostMapping
    public ResponseEntity<OrderDto> createOrder(@RequestBody OrderRequest request) {
        try {
            Order order = new Order();
            order.setUserId(request.getUserId());

            // Gộp địa chỉ thành shipping_address
            OrderRequest.CustomerInfo customer = request.getCustomer();
            StringBuilder shippingAddress = new StringBuilder();
            if (customer != null) {
                if (customer.getAddress() != null && !customer.getAddress().trim().isEmpty()) {
                    shippingAddress.append(customer.getAddress());
                }
                if (customer.getWard() != null && !customer.getWard().trim().isEmpty()) {
                    if (shippingAddress.length() > 0) shippingAddress.append(", ");
                    shippingAddress.append(customer.getWard());
                }
                if (customer.getDistrict() != null && !customer.getDistrict().trim().isEmpty()) {
                    if (shippingAddress.length() > 0) shippingAddress.append(", ");
                    shippingAddress.append(customer.getDistrict());
                }
                if (customer.getProvince() != null && !customer.getProvince().trim().isEmpty()) {
                    if (shippingAddress.length() > 0) shippingAddress.append(", ");
                    shippingAddress.append(customer.getProvince());
                }
                if (customer.getNote() != null && !customer.getNote().trim().isEmpty()) {
                    if (shippingAddress.length() > 0) shippingAddress.append(". Ghi chú: ");
                    shippingAddress.append(customer.getNote());
                }

                order.setCustomerName(customer.getName());
                order.setPhone(customer.getPhone());
            }

            // Tính total_amount = subtotal + shipping
            double totalAmount = request.getSubtotal() + request.getShipping();
            order.setTotalAmount(totalAmount);
            order.setShippingAddress(shippingAddress.toString());
            order.setStatus("PENDING");

            // Convert order items
            if (request.getItems() != null) {
                List<OrderItem> items = request.getItems().stream().map(itemRequest -> {
                    OrderItem item = new OrderItem();
                    item.setProductId(itemRequest.getProductId());
                    item.setQuantity(itemRequest.getQuantity());
                    item.setPrice(itemRequest.getPrice());
                    return item;
                }).collect(Collectors.toList());
                order.setItems(items);
            }

            Order createdOrder = orderService.createOrder(order);

            // Clear cart after successful order
            cartService.clearCart(request.getUserId());

            return ResponseEntity.ok(toDto(createdOrder, request));
        } catch (Exception e) {
            Map<String, String> error = new HashMap<>();
            error.put("error", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
        }
    }

    @GetMapping("/user/{userId}")
    public List<OrderDto> getOrdersByUser(@PathVariable("userId") int userId) {
        List<Order> orders = orderService.findByUserId(userId);
        return orders.stream().map(this::toDto).collect(Collectors.toList());
    }

    @GetMapping("/{orderId}")
    public ResponseEntity<OrderDto> getOrderById(@PathVariable("orderId") int orderId) {
        Order order = orderService.findById(orderId);
        if (order == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(toDto(order));
    }

    @GetMapping
    public List<OrderDto> getAllOrders() {
        List<Order> orders = orderService.findAll();
        return orders.stream().map(this::toDto).collect(Collectors.toList());
    }

    @PutMapping("/{orderId}/status")
    public ResponseEntity<OrderDto> updateOrderStatus(@PathVariable("orderId") int orderId,
                                                      @RequestBody Map<String, String> request) {
        String status = request.get("status");
        if (status == null || status.isEmpty()) {
            return ResponseEntity.badRequest().build();
        }

        orderService.updateStatus(orderId, status);
        Order order = orderService.findById(orderId);
        if (order == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(toDto(order));
    }

    @DeleteMapping("/{orderId}")
    public ResponseEntity<Void> deleteOrder(@PathVariable("orderId") int orderId) {
        orderService.deleteOrder(orderId);
        return ResponseEntity.noContent().build();
    }

    @ExceptionHandler(IllegalArgumentException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public Map<String, String> handleIllegalArgument(IllegalArgumentException ex) {
        Map<String, String> error = new HashMap<>();
        error.put("error", ex.getMessage());
        return error;
    }

    private OrderDto toDto(Order order) {
        return toDto(order, null);
    }

    private OrderDto toDto(Order order, OrderRequest originalRequest) {
        OrderDto dto = new OrderDto();
        dto.setId(order.getId());
        dto.setUserId(order.getUserId());
        dto.setCustomerName(order.getCustomerName());
        dto.setPhone(order.getPhone());
        dto.setStatus(order.getStatus());
        dto.setTotalAmount(order.getTotalAmount());
        dto.setShippingAddress(order.getShippingAddress());
        dto.setCreatedAt(order.getCreatedAt());
        dto.setUpdatedAt(order.getUpdatedAt());

        // Nếu có originalRequest, lấy thông tin chi tiết từ đó
        if (originalRequest != null && originalRequest.getCustomer() != null) {
            OrderRequest.CustomerInfo customer = originalRequest.getCustomer();
            dto.setCustomerName(customer.getName());
            dto.setEmail(customer.getEmail());
            dto.setAddress(customer.getAddress());
            dto.setProvince(customer.getProvince());
            dto.setDistrict(customer.getDistrict());
            dto.setWard(customer.getWard());
            dto.setNote(customer.getNote());
            dto.setPaymentMethod(originalRequest.getPaymentMethod());
            dto.setSubtotal(originalRequest.getSubtotal());
            dto.setShipping(originalRequest.getShipping());
            dto.setTotal(originalRequest.getTotal());
        } else {
            // Parse shipping_address để tách thành các trường (nếu có thể)
            String shippingAddr = order.getShippingAddress();
            if (shippingAddr != null) {
                dto.setAddress(shippingAddr);
            }
            // Tính toán lại từ total_amount (ước tính)
            dto.setTotal(order.getTotalAmount());
            // Giả sử shipping = 30000, subtotal = total - shipping
            double estimatedShipping = 30000;
            dto.setShipping(estimatedShipping);
            dto.setSubtotal(order.getTotalAmount() - estimatedShipping);
        }

        if (order.getItems() != null) {
            List<OrderItemDto> itemDtos = order.getItems().stream().map(this::toItemDto).collect(Collectors.toList());
            dto.setItems(itemDtos);
        }

        return dto;
    }

    private OrderItemDto toItemDto(OrderItem item) {
        OrderItemDto dto = new OrderItemDto();
        dto.setId(item.getId());
        dto.setOrderId(item.getOrderId());
        dto.setProductId(item.getProductId());
        dto.setQuantity(item.getQuantity());
        dto.setPrice(item.getPrice());
        dto.setCreatedAt(item.getCreatedAt());

        Product product = item.getProduct();
        if (product != null) {
            ProductDto productDto = new ProductDto(
                    product.getId(),
                    product.getName(),
                    product.getDescription(),
                    product.getPrice(),
                    product.getPriceSale(),
                    product.getStock(),
                    product.getImage(),
                    product.getCategoryName(),
                    product.getAlias()
            );
            productDto.setSeriesId(product.getSeriesId() == 0 ? null : product.getSeriesId());
            productDto.setSeriesName(product.getSeriesName());
            dto.setProduct(productDto);
        }

        return dto;
    }
}

