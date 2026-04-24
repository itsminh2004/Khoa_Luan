package khoaluantotnghiep.api.web;

import khoaluantotnghiep.model.UserAddress;
import khoaluantotnghiep.service.IUserAddressService;
import khoaluantotnghiep.service.impl.CustomUserDetails;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(origins = {"http://127.0.0.1:5500", "http://localhost:5500"}, allowCredentials = "true")
@RestController
@RequestMapping("/api/address")
public class AddressApiController {

    @Autowired
    private IUserAddressService addressService;

    @GetMapping
    public ResponseEntity<?> getMyAddresses() {
        int userId = getUserId();
        if (userId == -1) return unauthorized();

        List<UserAddress> addresses = addressService.getAddressesByUserId(userId);
        return ResponseEntity.ok(addresses);
    }

    @PostMapping
    public ResponseEntity<?> addAddress(@RequestBody UserAddress address) {
        int userId = getUserId();
        if (userId == -1) return unauthorized();

        address.setUserId(userId);
        boolean success = addressService.addAddress(address);
        if (success) {
            return ResponseEntity.status(HttpStatus.CREATED).body(new MessageResponse("Thêm địa chỉ thành công"));
        }
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(new MessageResponse("Thêm địa chỉ thất bại"));
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updateAddress(@PathVariable int id, @RequestBody UserAddress address) {
        int userId = getUserId();
        if (userId == -1) return unauthorized();

        UserAddress existing = addressService.getAddressById(id);
        if (existing == null || existing.getUserId() != userId) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(new MessageResponse("Không tìm thấy địa chỉ"));
        }

        address.setId(id);
        address.setUserId(userId);
        boolean success = addressService.updateAddress(address);
        if (success) {
            return ResponseEntity.ok(new MessageResponse("Cập nhật địa chỉ thành công"));
        }
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(new MessageResponse("Cập nhật địa chỉ thất bại"));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteAddress(@PathVariable int id) {
        int userId = getUserId();
        if (userId == -1) return unauthorized();

        UserAddress existing = addressService.getAddressById(id);
        if (existing == null || existing.getUserId() != userId) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(new MessageResponse("Không tìm thấy địa chỉ"));
        }

        boolean success = addressService.deleteAddress(id);
        if (success) {
            return ResponseEntity.ok(new MessageResponse("Xóa địa chỉ thành công"));
        }
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(new MessageResponse("Xóa địa chỉ thất bại"));
    }

    @PostMapping("/{id}/set-default")
    public ResponseEntity<?> setDefault(@PathVariable int id) {
        int userId = getUserId();
        if (userId == -1) return unauthorized();

        addressService.setDefault(userId, id);
        return ResponseEntity.ok(new MessageResponse("Đã đặt làm địa chỉ mặc định"));
    }

    private int getUserId() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.getPrincipal() instanceof CustomUserDetails) {
            return ((CustomUserDetails) auth.getPrincipal()).getUser().getId();
        }
        return -1;
    }

    private ResponseEntity<?> unauthorized() {
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(new MessageResponse("Chưa đăng nhập"));
    }

    public static class MessageResponse {
        private String message;
        public MessageResponse(String message) { this.message = message; }
        public String getMessage() { return message; }
    }
}
