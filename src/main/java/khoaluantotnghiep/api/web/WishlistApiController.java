package khoaluantotnghiep.api.web;

import khoaluantotnghiep.dto.ProductDto;
import khoaluantotnghiep.dto.WishlistItemDto;
import khoaluantotnghiep.dto.WishlistRequest;
import khoaluantotnghiep.model.Product;
import khoaluantotnghiep.model.WishlistItem;
import khoaluantotnghiep.service.IWishlistService;
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
@RequestMapping("/api/wishlist")
public class WishlistApiController {

    @Autowired
    private IWishlistService wishlistService;

    @GetMapping("/user/{userId}")
    public List<WishlistItemDto> getWishlist(@PathVariable("userId") int userId) {
        List<WishlistItem> items = wishlistService.getItemsByUser(userId);
        return items.stream().map(this::toDto).collect(Collectors.toList());
    }

    @PostMapping
    public ResponseEntity<WishlistItemDto> addWishlistItem(@RequestBody WishlistRequest request) {
        WishlistItem item = wishlistService.addItem(request.getUserId(), request.getProductId());
        return ResponseEntity.ok(toDto(item));
    }

    @DeleteMapping("/{wishlistItemId}")
    public ResponseEntity<Void> removeWishlistItem(@PathVariable("wishlistItemId") int wishlistItemId) {
        wishlistService.removeItem(wishlistItemId);
        return ResponseEntity.noContent().build();
    }

    @DeleteMapping("/user/{userId}/product/{productId}")
    public ResponseEntity<Void> removeWishlistItem(@PathVariable("userId") int userId,
                                                   @PathVariable("productId") int productId) {
        wishlistService.removeItem(userId, productId);
        return ResponseEntity.noContent().build();
    }

    @ExceptionHandler(IllegalArgumentException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public Map<String, String> handleIllegalArgument(IllegalArgumentException ex) {
        Map<String, String> error = new HashMap<>();
        error.put("error", ex.getMessage());
        return error;
    }

    private WishlistItemDto toDto(WishlistItem item) {
        WishlistItemDto dto = new WishlistItemDto();
        dto.setId(item.getId());
        dto.setUserId(item.getUserId());
        dto.setProductId(item.getProductId());
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


