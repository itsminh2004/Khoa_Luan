package khoaluantotnghiep.api.admin;

import khoaluantotnghiep.model.ProductImage;
import khoaluantotnghiep.model.Product;
import khoaluantotnghiep.service.IProductImageService;
import khoaluantotnghiep.service.IProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/product-images")
public class ProductImageApi {

    @Autowired
    private IProductImageService productImageService;

    @Autowired
    private IProductService productService;

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteImage(@PathVariable("id") int id, HttpServletRequest request) {
        Map<String, Object> response = new HashMap<>();
        try {
            ProductImage image = productImageService.findOne(id);
            if (image != null) {
                int productId = image.getProductId();
                String imageUrl = image.getImageUrl();

                // 1. Kiểm tra nếu ảnh này đang là ảnh chính của sản phẩm
                Product product = productService.findOne(productId);
                if (product != null && imageUrl != null && imageUrl.equals(product.getImage())) {
                    // Xóa ảnh đại diện trong bảng sản phẩm
                    product.setImage(null);
                    productService.update(product);
                }

                // 2. Xóa file vật lý
                if (imageUrl != null && !imageUrl.isEmpty()) {
                    String realPath = request.getServletContext().getRealPath(imageUrl);
                    if (realPath != null) {
                        File file = new File(realPath);
                        if (file.exists()) {
                            file.delete();
                        }
                    }
                }

                // 3. Xóa trong database
                productImageService.delete(id);

                response.put("success", true);
                response.put("message", "Đã xóa ảnh thành công");
                return ResponseEntity.ok(response);
            } else {
                response.put("success", false);
                response.put("message", "Không tìm thấy ảnh");
                return ResponseEntity.status(404).body(response);
            }
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Lỗi: " + e.getMessage());
            return ResponseEntity.status(500).body(response);
        }
    }
}
