package khoaluantotnghiep.controller.admin;

import khoaluantotnghiep.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@Controller("ControllerofAccount")
public class AccountController {
    @Autowired
    private IUserService userService;

    @RequestMapping(value = "/admin-account" , method = RequestMethod.GET)
    public ModelAndView adminAccount(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/admin/account/index");
        mav.addObject("listAccount", userService.getAllUsers());
        return mav;
    }
    @RequestMapping(value = "/admin-account-updateRole/{id}" , method = RequestMethod.GET)
    public ModelAndView adminAccountUpdateRole(@PathVariable("id") int id) {
        ModelAndView mav = new ModelAndView("/admin/account/update");
        mav.addObject("AccountId", userService.findOne(id));
        return mav;
    }
    @RequestMapping(value = "/admin-account-updateRole/{id}", method = RequestMethod.POST)
    public String UpdateRole(HttpServletRequest request,
                                        @RequestParam("userId")int userId,
                                        @RequestParam("role") String role) {
        userService.updateUserRole(userId, role);
        return "redirect:/admin-account";
    }
    @RequestMapping(value = "/admin-account-delete/{id}", method = RequestMethod.GET)
    public String deleteAccount(@PathVariable("id") int id) {
        userService.delete(id);
        return "redirect:/admin-account";
    }
}
