package khoaluantotnghiep.controller.admin;

import khoaluantotnghiep.service.IRoleService;
import khoaluantotnghiep.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.Arrays;
import java.util.List;

@Controller("ControllerofAccount")
public class AccountController {
    @Autowired
    private IUserService userService;

    @Autowired
    private IRoleService roleService;

    @RequestMapping(value = "/admin-account", method = RequestMethod.GET)
    public ModelAndView adminAccount(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/admin/account/index");
        mav.addObject("listAccount", userService.getAllUsers());
        return mav;
    }

    @RequestMapping(value = "/admin-account-updateRole/{id}", method = RequestMethod.GET)
    public ModelAndView adminAccountUpdateRole(@PathVariable("id") int id) {
        ModelAndView mav = new ModelAndView("/admin/account/update");
        mav.addObject("AccountId", userService.findOne(id));

        // Thêm danh sách available roles để hiển thị checkboxes
        mav.addObject("availableRoles", roleService.getAvailableRoles());

        // Lấy roles hiện tại của user
        mav.addObject("userRoles", roleService.getUserRoles(id));

        return mav;
    }

    @RequestMapping(value = "/admin-account-updateRole/{id}", method = RequestMethod.POST)
    public String UpdateRole(HttpServletRequest request,
                             @PathVariable("id") int userId,
                             @RequestParam(value = "roles", required = false) String[] roles,
                             RedirectAttributes redirectAttributes) {
        try {
            // Convert array to list
            List<String> roleList = roles != null ? Arrays.asList(roles) : new java.util.ArrayList<>();

            // Cập nhật roles
            boolean success = roleService.updateUserRoles(userId, roleList);

            if (success) {
                redirectAttributes.addFlashAttribute("message", "Cập nhật phân quyền thành công!");
                redirectAttributes.addFlashAttribute("alertType", "success");
            } else {
                redirectAttributes.addFlashAttribute("message", "Cập nhật phân quyền thất bại!");
                redirectAttributes.addFlashAttribute("alertType", "danger");
            }
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("message", "Có lỗi xảy ra: " + e.getMessage());
            redirectAttributes.addFlashAttribute("alertType", "danger");
        }

        return "redirect:/admin-account";
    }

    @RequestMapping(value = "/admin-account-delete/{id}", method = RequestMethod.GET)
    public String deleteAccount(@PathVariable("id") int id) {
        userService.delete(id);
        return "redirect:/admin-account";
    }
}
