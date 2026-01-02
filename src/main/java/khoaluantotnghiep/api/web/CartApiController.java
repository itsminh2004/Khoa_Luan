package khoaluantotnghiep.api.web;

import khoaluantotnghiep.dto.CartItemDto;
import khoaluantotnghiep.dto.CartRequest;
import khoaluantotnghiep.dto.CartUpdateRequest;
import khoaluantotnghiep.dto.ProductDto;
import khoaluantotnghiep.model.CartItem;
import khoaluantotnghiep.model.Product;
import khoaluantotnghiep.service.ICartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@CrossOrigin(origins = {"http://127.0.0.1:5500", "http://localhost:5500"}, allowCredentials = "true")
@RestController
@RequestMapping("/api/cart")
public class CartApiController {

    @Autowired
    private ICartService cartService;

    @GetMapping("/user/{userId}")
    public List<CartItemDto> getCartItems(@PathVariable("userId") int userId) {
        List<CartItem> items = cartService.getItemsByUser(userId);
        return items.stream().map(this::toDto).collect(Collectors.toList());
    }

    @PostMapping
    public ResponseEntity<CartItemDto> addToCart(@RequestBody CartRequest request) {
        int quantity = request.getQuantity() <= 0 ? 1 : request.getQuantity();
        CartItem item = cartService.addItem(request.getUserId(), request.getProductId(), quantity);
        return ResponseEntity.ok(toDto(item));
    }

    @PutMapping("/{cartItemId}")
    public ResponseEntity<CartItemDto> updateQuantity(@PathVariable("cartItemId") int cartItemId,
                                                      @RequestBody CartUpdateRequest request) {
        int quantity = request.getQuantity();
        if (quantity <= 0) {
            return ResponseEntity.badRequest().build();
        }

        CartItem updated = cartService.updateQuantity(cartItemId, quantity);
        if (updated == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(toDto(updated));
    }

    @DeleteMapping("/{cartItemId}")
    public ResponseEntity<Void> removeItem(@PathVariable("cartItemId") int cartItemId) {
        cartService.removeItem(cartItemId);
        return ResponseEntity.noContent().build();
    }

    @DeleteMapping("/user/{userId}/product/{productId}")
    public ResponseEntity<Void> removeItemByUserAndProduct(@PathVariable("userId") int userId,
                                                           @PathVariable("productId") int productId) {
        cartService.removeItem(userId, productId);
        return ResponseEntity.noContent().build();
    }

    @DeleteMapping("/user/{userId}")
    public ResponseEntity<Void> clearCart(@PathVariable("userId") int userId) {
        cartService.clearCart(userId);
        return ResponseEntity.noContent().build();
    }

    @ExceptionHandler(IllegalArgumentException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public Map<String, String> handleIllegalArgument(IllegalArgumentException ex) {
        Map<String, String> error = new HashMap<>();
        error.put("error", ex.getMessage());
        return error;
    }

    private CartItemDto toDto(CartItem item) {
        CartItemDto dto = new CartItemDto();
        dto.setId(item.getId());
        dto.setUserId(item.getUserId());
        dto.setProductId(item.getProductId());
        dto.setQuantity(item.getQuantity());
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


