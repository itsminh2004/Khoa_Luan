package khoaluantotnghiep.controller.login;

import khoaluantotnghiep.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

@Controller
public class ForgotpasswordController {

    @Autowired
    private IUserService userService;

    @GetMapping("/forgot-password")
    public String showForgotPasswordForm() {
        return "login/forgot-password";
    }

    @PostMapping("/forgot-password")
    public String sendResetCode(@RequestParam("email") String email, Model model, HttpSession session) {
        boolean success = userService.sendPasswordResetCode(email);

        if (success) {
            // Lưu email vào session để reset password
            session.setAttribute("email_for_reset", email);
            model.addAttribute("message", "Mã đặt lại mật khẩu đã được gửi vào email của bạn!");
            return "login/reset-password"; // Trang nhập mã và mật khẩu mới
        } else {
            model.addAttribute("error", "Email không tồn tại trong hệ thống!");
            return "login/forgot-password";
        }
    }

    @GetMapping("/reset-password")
    public String showResetPasswordForm(HttpSession session, Model model) {
        String email = (String) session.getAttribute("email_for_reset");
        if (email == null) {
            model.addAttribute("error", "Vui lòng bắt đầu từ trang quên mật khẩu!");
            return "redirect:/forgot-password";
        }
        return "login/reset-password";
    }

    @PostMapping("/reset-password")
    public String resetPassword(@RequestParam("code") String code,
                                @RequestParam("newPassword") String newPassword,
                                @RequestParam("confirmPassword") String confirmPassword,
                                HttpSession session, Model model) {
        String email = (String) session.getAttribute("email_for_reset");

        if (email == null) {
            model.addAttribute("error", "Phiên làm việc đã hết hạn. Vui lòng thử lại!");
            return "redirect:/forgot-password";
        }

        // Kiểm tra mật khẩu xác nhận
        if (!newPassword.equals(confirmPassword)) {
            model.addAttribute("error", "Mật khẩu xác nhận không khớp!");
            return "login/reset-password";
        }

        // Kiểm tra độ dài mật khẩu
        if (newPassword.length() < 6) {
            model.addAttribute("error", "Mật khẩu phải có ít nhất 6 ký tự!");
            return "login/reset-password";
        }

        // Đặt lại mật khẩu
        boolean success = userService.resetPassword(email, code, newPassword);

        if (success) {
            session.removeAttribute("email_for_reset");
            model.addAttribute("message", "Đặt lại mật khẩu thành công! Bạn có thể đăng nhập.");
            return "login/login";
        } else {
            model.addAttribute("error", "Mã xác nhận không đúng hoặc đã hết hạn!");
            return "login/reset-password";
        }
    }
}
