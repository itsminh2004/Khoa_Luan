package khoaluantotnghiep.controller.login;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller(value = "ControllerofLogin")
public class LoginController {

    @RequestMapping(value = "/login")
    public String loginPage() {
        return "login/login";
    }

    @RequestMapping(value = "/admin-home")
    public String adminHome() {
        return "admin/home/index";
    }
    
    // Logout is handled by Spring Security, but we can add a logout page if needed
    @GetMapping(value = "/logout")
    public String logout() {
        return "redirect:/login";
    }
}
