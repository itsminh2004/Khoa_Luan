package khoaluantotnghiep.api.web;

import khoaluantotnghiep.dto.*;
import khoaluantotnghiep.model.Coupon;
import khoaluantotnghiep.model.Order;
import khoaluantotnghiep.model.OrderItem;
import khoaluantotnghiep.model.Product;
import khoaluantotnghiep.model.ProductVariantNew;
import khoaluantotnghiep.service.ICartService;
import khoaluantotnghiep.service.ICouponService;
import khoaluantotnghiep.service.IOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@CrossOrigin(origins = { "http://127.0.0.1:5500", "http://localhost:5500" })
@RestController
@RequestMapping("/api/orders")
public class OrderApiController {

    @Autowired
    private IOrderService orderService;

    @Autowired
    private ICartService cartService;

    @Autowired
    private ICouponService couponService;

    @PostMapping
    public ResponseEntity<?> createOrder(@RequestBody OrderRequest request) {
        try {
            Order order = new Order();
            order.setUserId(request.getUserId());

            // --- TÍNH TOÁN LẠI TIỀN & MÃ GIẢM GIÁ Ở BACKEND ---
            // Không hoàn toàn tin vào subtotal/discount từ FE, nhưng vẫn dùng làm input.
            double subtotal = request.getSubtotal();
            double shipping = request.getShipping();
            double discount = 0;

            // Gộp địa chỉ thành shipping_address
            OrderRequest.CustomerInfo customer = request.getCustomer();
            StringBuilder shippingAddress = new StringBuilder();
            if (customer != null) {
                if (customer.getAddress() != null && !customer.getAddress().trim().isEmpty()) {
                    shippingAddress.append(customer.getAddress());
                }
                if (customer.getWard() != null && !customer.getWard().trim().isEmpty()) {
                    if (shippingAddress.length() > 0)
                        shippingAddress.append(", ");
                    shippingAddress.append(customer.getWard());
                }
                if (customer.getDistrict() != null && !customer.getDistrict().trim().isEmpty()) {
                    if (shippingAddress.length() > 0)
                        shippingAddress.append(", ");
                    shippingAddress.append(customer.getDistrict());
                }
                if (customer.getProvince() != null && !customer.getProvince().trim().isEmpty()) {
                    if (shippingAddress.length() > 0)
                        shippingAddress.append(", ");
                    shippingAddress.append(customer.getProvince());
                }
                if (customer.getNote() != null && !customer.getNote().trim().isEmpty()) {
                    if (shippingAddress.length() > 0)
                        shippingAddress.append(". Ghi chú: ");
                    shippingAddress.append(customer.getNote());
                }

                order.setCustomerName(customer.getName());
                order.setPhone(customer.getPhone());
            }

            // ✅ Xử lý & validate mã giảm giá trên backend nếu có
            if (request.getCouponId() != null && request.getCouponId() > 0) {
                try {
                    Coupon coupon = couponService.findOne(request.getCouponId());
                    if (coupon != null && couponService.isValid(coupon.getCode(), subtotal)) {
                        // Tính lại số tiền giảm dựa trên loại coupon
                        if ("PERCENT".equals(coupon.getDiscountType())) {
                            discount = subtotal * (coupon.getDiscountValue() / 100.0);
                            if (coupon.getMaxDiscountAmount() != null
                                    && discount > coupon.getMaxDiscountAmount()) {
                                discount = coupon.getMaxDiscountAmount();
                            }
                        } else if ("AMOUNT".equals(coupon.getDiscountType())) {
                            discount = coupon.getDiscountValue();
                        }

                        order.setCouponId(coupon.getId());
                        order.setDiscountAmount(discount);
                    }
                } catch (Exception ignore) {
                    // Nếu có lỗi khi xử lý coupon thì bỏ qua, không làm fail đơn
                }
            }

            // Tính total_amount = subtotal + shipping - discount (không âm)
            double totalAmount = Math.max(0, subtotal + shipping - discount);
            order.setTotalAmount(totalAmount);
            order.setShippingAddress(shippingAddress.toString());
            order.setPaymentMethod(request.getPaymentMethod());
            order.setStatus("PENDING");

            // Convert order items
            if (request.getItems() != null) {
                List<OrderItem> items = new java.util.ArrayList<>();
                for (OrderRequest.OrderItemRequest itemRequest : request.getItems()) {
                    OrderItem item = new OrderItem();
                    item.setProductId(itemRequest.getProductId());

                    Integer vId = itemRequest.getVariantId();
                    if (vId != null && vId <= 0)
                        vId = null; // Normalize 0 or negative to null
                    item.setVariantId(vId);

                    item.setQuantity(itemRequest.getQuantity());
                    item.setPrice(itemRequest.getPrice());
                    items.add(item);
                }
                order.setItems(items);
            }

            Order createdOrder = orderService.createOrder(order);

            // ✅ Tăng usedCount của coupon sau khi tạo đơn hàng thành công
            if (request.getCouponId() != null && request.getCouponId() > 0) {
                try {
                    Coupon coupon = couponService.findOne(request.getCouponId());
                    if (coupon != null) {
                        coupon.setUsedCount(coupon.getUsedCount() + 1);
                        couponService.save(coupon);
                    }
                } catch (Exception e) {
                    // Log error nhưng không làm fail đơn hàng
                    System.err.println("Error updating coupon usedCount: " + e.getMessage());
                }
            }

            // Clear cart immediately ONLY if COD
            // For BANK_TRANSFER (VNPAY) or MOMO, wait for payment callback
            if ("COD".equalsIgnoreCase(request.getPaymentMethod())) {
                cartService.clearCart(request.getUserId());
            }

            return ResponseEntity.ok(toDto(createdOrder, request));
        } catch (Exception e) {
            Map<String, String> error = new HashMap<>();
            error.put("error", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(error);
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
        dto.setPaymentMethod(order.getPaymentMethod());

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
            // Tổng thực tế lấy từ order (đã trừ giảm giá nếu có)
            dto.setTotal(order.getTotalAmount());
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
        dto.setVariantId(item.getVariantId());
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
                    product.getAlias(),
                    product.isActive());
            productDto.setSeriesId(product.getSeriesId() == 0 ? null : product.getSeriesId());
            productDto.setSeriesName(product.getSeriesName());
            dto.setProduct(productDto);
        }

        // Map variant information
        if (item.getVariant() != null) {
            ProductVariantNew variant = item.getVariant();
            ProductVariantNewDto variantDto = new ProductVariantNewDto();
            variantDto.setId(variant.getId());
            variantDto.setColorId(variant.getColorId());
            variantDto.setRamRomId(variant.getRamRomId());
            variantDto.setPrice(variant.getPrice());
            variantDto.setPriceSale(variant.getPriceSale());
            variantDto.setStock(variant.getStock());

            if (variant.getColor() != null) {
                variantDto.setColorName(variant.getColor().getColorName());
            }
            if (variant.getRamRom() != null) {
                String ramRomStr = variant.getRamRom().getRam() + "GB / " + variant.getRamRom().getRom() + "GB";
                variantDto.setRamRom(ramRomStr);
            }

            dto.setVariant(variantDto);
        }

        return dto;
    }
}
