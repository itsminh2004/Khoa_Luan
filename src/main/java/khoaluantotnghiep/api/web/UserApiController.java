package khoaluantotnghiep.api.web;

import khoaluantotnghiep.model.User;
import khoaluantotnghiep.service.IUserService;
import khoaluantotnghiep.service.impl.CustomUserDetails;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = {"http://127.0.0.1:5500", "http://localhost:5500"}, allowCredentials = "true")
@RestController
@RequestMapping("/api/user")
public class UserApiController {

    @Autowired
    private IUserService userService;

    @GetMapping("/profile")
    public ResponseEntity<?> getProfile() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !(authentication.getPrincipal() instanceof CustomUserDetails)) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(new ErrorResponse("Chưa đăng nhập"));
        }

        CustomUserDetails principal = (CustomUserDetails) authentication.getPrincipal();
        User user = userService.findOne(principal.getUser().getId());
        if (user == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(new ErrorResponse("Không tìm thấy người dùng"));
        }

        // Hide password
        user.setPassword(null);
        return ResponseEntity.ok(user);
    }

    @PostMapping("/update-profile")
    public ResponseEntity<?> updateProfile(@RequestBody UpdateProfileRequest request) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !(authentication.getPrincipal() instanceof CustomUserDetails)) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(new ErrorResponse("Chưa đăng nhập"));
        }

        CustomUserDetails principal = (CustomUserDetails) authentication.getPrincipal();
        int userId = principal.getUser().getId();

        boolean success = userService.updateProfile(userId, request.getFullName());
        if (success) {
            User updatedUser = userService.findOne(userId);
            updatedUser.setPassword(null);
            return ResponseEntity.ok(updatedUser);
        } else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(new ErrorResponse("Cập nhật thất bại"));
        }
    }

    @PostMapping("/change-password")
    public ResponseEntity<?> changePassword(@RequestBody ChangePasswordRequest request) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !(authentication.getPrincipal() instanceof CustomUserDetails)) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(new ErrorResponse("Chưa đăng nhập"));
        }

        CustomUserDetails principal = (CustomUserDetails) authentication.getPrincipal();
        String email = principal.getUser().getEmail();

        if (request.getNewPassword().length() < 6) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(new ErrorResponse("Mật khẩu mới phải có ít nhất 6 ký tự"));
        }

        if (!request.getNewPassword().equals(request.getConfirmPassword())) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(new ErrorResponse("Mật khẩu xác nhận không khớp"));
        }

        boolean success = userService.changePassword(email, request.getOldPassword(), request.getNewPassword());
        if (success) {
            return ResponseEntity.ok(new SuccessResponse("Đổi mật khẩu thành công"));
        } else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(new ErrorResponse("Mật khẩu cũ không đúng"));
        }
    }

    // DTOs
    public static class UpdateProfileRequest {
        private String fullName;

        public String getFullName() { return fullName; }
        public void setFullName(String fullName) { this.fullName = fullName; }
    }

    public static class ChangePasswordRequest {
        private String oldPassword;
        private String newPassword;
        private String confirmPassword;

        public String getOldPassword() { return oldPassword; }
        public void setOldPassword(String oldPassword) { this.oldPassword = oldPassword; }
        public String getNewPassword() { return newPassword; }
        public void setNewPassword(String newPassword) { this.newPassword = newPassword; }
        public String getConfirmPassword() { return confirmPassword; }
        public void setConfirmPassword(String confirmPassword) { this.confirmPassword = confirmPassword; }
    }

    public static class ErrorResponse {
        private String error;
        public ErrorResponse(String error) { this.error = error; }
        public String getError() { return error; }
    }

    public static class SuccessResponse {
        private String message;
        public SuccessResponse(String message) { this.message = message; }
        public String getMessage() { return message; }
    }
}
