package khoaluantotnghiep.controller.admin;

import khoaluantotnghiep.service.IRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Map;

@Controller
@RequestMapping("/admin-roles")
public class RoleController {

    @Autowired
    private IRoleService roleService;

    @GetMapping
    public String index(Model model) {
        Map<String, String> availableRoles = roleService.getAvailableRoles();
        model.addAttribute("availableRoles", availableRoles);
        return "admin/role/index";
    }
}
