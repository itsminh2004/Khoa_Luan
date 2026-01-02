package khoaluantotnghiep.api.web;

import khoaluantotnghiep.dto.LoginRequest;
import khoaluantotnghiep.dto.LoginResponse;
import khoaluantotnghiep.model.User;
import khoaluantotnghiep.service.IUserService;
import khoaluantotnghiep.service.impl.CustomUserDetails;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@CrossOrigin(origins = {"http://127.0.0.1:5500", "http://localhost:5500"}, allowCredentials = "true")
@RestController
@RequestMapping("/api/auth")
public class AuthApiController {

    @Autowired
    private IUserService userService;

    @Autowired
    private AuthenticationManager authenticationManager;

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody LoginRequest request, HttpSession session) {
        if (request.getEmail() == null || request.getPassword() == null) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(error("Email và mật khẩu không được để trống"));
        }

        try {
            Authentication authentication = authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(request.getEmail(), request.getPassword())
            );

            // Lưu authentication vào SecurityContext và session để Spring Security quản lý
            SecurityContext context = SecurityContextHolder.createEmptyContext();
            context.setAuthentication(authentication);
            SecurityContextHolder.setContext(context);
            session.setAttribute(HttpSessionSecurityContextRepository.SPRING_SECURITY_CONTEXT_KEY, context);

            CustomUserDetails principal = (CustomUserDetails) authentication.getPrincipal();
            User user = principal.getUser();
            String effectiveRole = resolveRole(user);

            LoginResponse response = new LoginResponse(
                    user.getId(),
                    user.getEmail(),
                    user.getFullName(),
                    effectiveRole
            );
            return ResponseEntity.ok(response);
        } catch (BadCredentialsException ex) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body(error("Email hoặc mật khẩu không đúng"));
        }
    }

    @PostMapping("/logout")
    public ResponseEntity<?> logout(HttpSession session) {
        SecurityContextHolder.clearContext();
        session.invalidate();
        return ResponseEntity.ok().build();
    }

    @PostMapping("/forgot-password")
    public ResponseEntity<?> forgotPassword(@RequestBody ForgotPasswordRequest request) {
        if (request.getEmail() == null || request.getEmail().trim().isEmpty()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(error("Email không được để trống"));
        }

        boolean success = userService.sendPasswordResetCode(request.getEmail());
        if (success) {
            return ResponseEntity.ok(new SuccessResponse("Mã đặt lại mật khẩu đã được gửi vào email của bạn!"));
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(error("Email không tồn tại trong hệ thống"));
        }
    }

    @PostMapping("/reset-password")
    public ResponseEntity<?> resetPassword(@RequestBody ResetPasswordRequest request) {
        if (request.getEmail() == null || request.getCode() == null || request.getNewPassword() == null) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(error("Vui lòng nhập đầy đủ thông tin"));
        }

        if (request.getNewPassword().length() < 6) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(error("Mật khẩu phải có ít nhất 6 ký tự"));
        }

        boolean success = userService.resetPassword(request.getEmail(), request.getCode(), request.getNewPassword());
        if (success) {
            return ResponseEntity.ok(new SuccessResponse("Đặt lại mật khẩu thành công!"));
        } else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(error("Mã xác nhận không đúng hoặc đã hết hạn"));
        }
    }

    private String resolveRole(User user) {
        if (user.getRoles() != null) {
            for (String role : user.getRoles()) {
                if (role == null) continue;
                String normalized = role.startsWith("ROLE_") ? role.substring(5) : role;
                if ("ADMIN".equalsIgnoreCase(normalized)) {
                    return "ADMIN";
                } else if ("USER".equalsIgnoreCase(normalized)) {
                    return "USER";
                }
            }
        }
        return "USER";
    }

    private static ErrorResponse error(String message) {
        return new ErrorResponse(message);
    }

    private static class ErrorResponse {
        private final String error;

        private ErrorResponse(String error) {
            this.error = error;
        }

        public String getError() {
            return error;
        }
    }

    private static class SuccessResponse {
        private final String message;

        private SuccessResponse(String message) {
            this.message = message;
        }

        public String getMessage() {
            return message;
        }
    }

    private static class ForgotPasswordRequest {
        private String email;

        public String getEmail() {
            return email;
        }

        public void setEmail(String email) {
            this.email = email;
        }
    }

    private static class ResetPasswordRequest {
        private String email;
        private String code;
        private String newPassword;

        public String getEmail() {
            return email;
        }

        public void setEmail(String email) {
            this.email = email;
        }

        public String getCode() {
            return code;
        }

        public void setCode(String code) {
            this.code = code;
        }

        public String getNewPassword() {
            return newPassword;
        }

        public void setNewPassword(String newPassword) {
            this.newPassword = newPassword;
        }
    }
}

