package khoaluantotnghiep.controller.login;

import khoaluantotnghiep.model.User;
import khoaluantotnghiep.service.IEmailService;
import khoaluantotnghiep.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

@Controller
public class RegisterController {

    @Autowired
    private IUserService userService;

    @Autowired
    private IEmailService emailService;

    @GetMapping("/register")
    public String showRegisterForm() {
        return "login/register";
    }

    @PostMapping("/register")
    public String register(@RequestParam("email") String email,
                           @RequestParam("fullName") String fullName,
                           @RequestParam("password") String password,
                           Model model, HttpSession session) {

        boolean success = userService.registerAndSendOTP(email, fullName, password);

        if (success) {
            // Lưu email vào session để verify OTP
            session.setAttribute("email_for_verification", email);
            model.addAttribute("message", "Mã xác nhận đã được gửi vào email của bạn!");
            return "login/verify"; // Trang nhập OTP
        } else {
            model.addAttribute("error", "Email đã tồn tại hoặc có lỗi, vui lòng thử lại!");
            return "login/register";
        }
    }

    @GetMapping("/verify")
    public String showVerifyForm() {
        return "login/verify";
    }

    @PostMapping("/verify")
    public String verifyOTP(@RequestParam("code") String code, HttpSession session, Model model) {
        String email = (String) session.getAttribute("email_for_verification");
        if (email != null) {
            // Sử dụng verifyOTP đã cập nhật enabled
            User user = userService.verifyOTP(email, code);
            if (user != null) {
                session.removeAttribute("email_for_verification");
                model.addAttribute("message", "Xác thực thành công! Bạn có thể đăng nhập.");
                return "login/login";
            } else {
                model.addAttribute("error", "Mã OTP không đúng hoặc đã hết hạn.");
                return "login/verify";
            }
        }
        return "redirect:/register";
    }
}

