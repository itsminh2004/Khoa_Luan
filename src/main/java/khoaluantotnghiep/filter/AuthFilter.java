package khoaluantotnghiep.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException { }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);
        Object userObj = (session != null) ? session.getAttribute("user") : null;
        String role = (session != null) ? (String) session.getAttribute("role") : null;

        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();
        String path = uri.substring(contextPath.length());

        // ======================
        // 1. PHÂN LOẠI URL
        // ======================
        boolean isWebLogin      = path.startsWith("/login");
        boolean isWebRegister   = path.startsWith("/register");
        boolean isWebForgotPassword    = path.startsWith("/forgot-password");
        boolean isWebResetPassword     = path.startsWith("/reset-password");

        boolean isPublicProduct   = path.startsWith("/api/products");
        boolean isPublicCategory  = path.startsWith("/api/categories");
        boolean isMenuShop        = path.startsWith("/api/menu");
        boolean isBlogShop        = path.startsWith("/api/blog");
        boolean isAuthApi         = path.startsWith("/api/auth");

        boolean isCartApi         = path.startsWith("/api/cart");
        boolean isWishlistApi     = path.startsWith("/api/wishlist");
        boolean isOrdersApi       = path.startsWith("/api/orders");

        boolean isOptionsPreflight = "OPTIONS".equalsIgnoreCase(req.getMethod());

        boolean isStaticResource =
                path.startsWith("/template/") || path.startsWith("/resources/") ||
                        path.endsWith(".css") || path.endsWith(".js") ||
                        path.endsWith(".png") || path.endsWith(".jpg") ||
                        path.endsWith(".jpeg") || path.endsWith(".gif");

        // API CÔNG KHAI (ai cũng vào được)
        boolean isPublicApi = isPublicProduct || isPublicCategory || isMenuShop || isAuthApi || isBlogShop;

        // API BẢO VỆ (phải login)
        boolean isProtectedApi = isCartApi || isWishlistApi || isOrdersApi;

        boolean isApi = path.startsWith("/api/");

        // ======================
        // 2. CHO QUA OPTIONS (CORS)
        // ======================
        if (isOptionsPreflight) {
            chain.doFilter(request, response);
            return;
        }

        // ======================
        // 3. CHƯA LOGIN → CHẶN PROTECTED API
        // ======================
        if (userObj == null) {
            if (isProtectedApi) {
                if (isApi) {
                    res.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Vui lòng đăng nhập để sử dụng giỏ hàng hoặc danh sách yêu thích");
                } else {
                    res.sendRedirect(req.getContextPath() + "/login");
                }
                return;
            }

            // Chặn API không public và không protected
            if (isApi && !isPublicApi) {
                res.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Chưa đăng nhập");
                return;
            }

            // Chặn web page không phải login/register
            if (!isApi && !(isWebLogin || isWebRegister || isWebForgotPassword || isWebResetPassword || isStaticResource)) {
                res.sendRedirect(contextPath + "/login");
                return;
            }
        }

        // ======================
        // 4. ĐÃ LOGIN → CHO PHÉP TẤT CẢ
        // ======================
        // (Không cần làm gì)

        // ======================
        // 5. KIỂM TRA QUYỀN (USER KHÔNG VÀO ADMIN)
        // ======================
        if (role != null && "USER".equalsIgnoreCase(role) && path.startsWith("/admin")) {
            if (isApi) {
                res.sendError(HttpServletResponse.SC_FORBIDDEN, "Không có quyền truy cập");
            } else {
                res.sendRedirect(contextPath + "/trang-chu");
            }
            return;
        }

        // ======================
        // 6. ĐI TIẾP
        // ======================
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() { }
}