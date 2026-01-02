package khoaluantotnghiep.utils;

import khoaluantotnghiep.model.User;
import khoaluantotnghiep.service.impl.CustomUserDetails;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

public class SecurityUtils {

    /**
     * Lấy User hiện tại từ SecurityContext
     * @return User object hoặc null nếu chưa đăng nhập
     */
    public static User getCurrentUser() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof CustomUserDetails) {
            CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
            return userDetails.getUser();
        }
        return null;
    }

    /**
     * Lấy userId hiện tại từ SecurityContext
     * @return userId hoặc -1 nếu chưa đăng nhập
     */
    public static int getCurrentUserId() {
        User user = getCurrentUser();
        return user != null ? user.getId() : -1;
    }

    /**
     * Kiểm tra xem user hiện tại có phải là ADMIN không
     * @return true nếu là ADMIN
     */
    public static boolean isAdmin() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getAuthorities() != null) {
            return authentication.getAuthorities().stream()
                    .anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"));
        }
        return false;
    }
}

