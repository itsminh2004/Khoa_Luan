package khoaluantotnghiep.controller.admin;

import khoaluantotnghiep.model.AdminProfile;
import khoaluantotnghiep.service.IAdminProfileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
public class AdminProfileController {

    @Autowired
    private IAdminProfileService adminProfileService;

    /**
     * Hiển thị profile của toàn bộ tài khoản trong admin.
     */
    @RequestMapping(value = "/admin-profile", method = RequestMethod.GET)
    public ModelAndView adminProfile(
            @RequestParam(value = "keyword", required = false) String keyword,
            @RequestParam(value = "role", required = false) String role
    ) {
        List<AdminProfile> profiles = adminProfileService.searchProfiles(keyword, role);
        List<String> distinctRoles = adminProfileService.getDistinctRoles();

        ModelAndView mav = new ModelAndView("admin/profile/profile");
        mav.addObject("profiles", profiles);
        mav.addObject("pageTitle", "Admin Profile");
        mav.addObject("keyword", keyword);
        mav.addObject("selectedRole", role);
        mav.addObject("rolesFilter", distinctRoles);
        return mav;
    }

    /**
     * Trang xem chi tiết thông tin (read-only) cho 1 tài khoản cụ thể.
     */
    @RequestMapping(value = "/admin-profile-detail/{userId}", method = RequestMethod.GET)
    public ModelAndView adminProfileDetailPage(@PathVariable("userId") int userId) {
        AdminProfile profile = adminProfileService.getProfileByUserId(userId);
        ModelAndView mav = new ModelAndView("admin/profile/detail");
        mav.addObject("profile", profile);
        mav.addObject("pageTitle", "Chi tiết tài khoản");
        return mav;
    }

    /**
     * Trang update cho 1 tài khoản cụ thể.
     */
    @RequestMapping(value = "/admin-profile-update/{userId}", method = RequestMethod.GET)
    public ModelAndView adminProfileUpdatePage(@PathVariable("userId") int userId) {
        AdminProfile profile = adminProfileService.getProfileByUserId(userId);
        ModelAndView mav = new ModelAndView("admin/profile/update");
        mav.addObject("profile", profile);
        mav.addObject("pageTitle", "Cập nhật profile");
        return mav;
    }

    /**
     * Cập nhật thông tin profile (username/email/phone + địa chỉ mặc định) của 1 tài khoản.
     */
    @RequestMapping(value = "/admin-profile-update", method = RequestMethod.POST)
    public String adminProfileUpdate(
            @RequestParam("userId") int userId,
            @RequestParam("fullName") String fullName,
            @RequestParam("email") String email,
            @RequestParam("phone") String phone,
            @RequestParam(value = "province", required = false) String province,
            @RequestParam(value = "district", required = false) String district,
            @RequestParam(value = "ward", required = false) String ward,
            @RequestParam(value = "specificAddress", required = false) String specificAddress,
            RedirectAttributes redirectAttributes
    ) {
        // Validate dữ liệu cơ bản: email và phone không rỗng
        String normalizedEmail = email != null ? email.trim() : "";
        String normalizedPhone = phone != null ? phone.trim() : "";

        if (normalizedEmail.isEmpty() || normalizedPhone.isEmpty()) {
            redirectAttributes.addFlashAttribute("message", "Email và Số điện thoại không được rỗng!");
            return "redirect:/admin-profile";
        }

        String normalizedFullName = fullName != null ? fullName.trim() : "";
        String normalizedProvince = province != null ? province.trim() : "";
        String normalizedDistrict = district != null ? district.trim() : "";
        String normalizedWard = ward != null ? ward.trim() : "";
        String normalizedSpecificAddress = specificAddress != null ? specificAddress.trim() : "";

        boolean success = adminProfileService.updateProfile(
                userId,
                normalizedFullName,
                normalizedEmail,
                normalizedPhone,
                normalizedProvince,
                normalizedDistrict,
                normalizedWard,
                normalizedSpecificAddress
        );

        if (success) {
            redirectAttributes.addFlashAttribute("message", "Cập nhật profile thành công!");
        } else {
            redirectAttributes.addFlashAttribute("message", "Cập nhật profile thất bại!");
        }

        return "redirect:/admin-profile";
    }
    @RequestMapping(value = "/admin-profile-password/{userId}", method = RequestMethod.GET)
    public ModelAndView adminProfilePasswordPage(@PathVariable("userId") int userId) {
        AdminProfile profile = adminProfileService.getProfileByUserId(userId);
        ModelAndView mav = new ModelAndView("admin/profile/password");
        mav.addObject("profile", profile);
        mav.addObject("pageTitle", "Đổi mật khẩu");
        return mav;
    }
    @RequestMapping(value = "/admin-profile-password", method = RequestMethod.POST)
    public String adminProfilePassword(@RequestParam("userId") int userId,
                                       @RequestParam("oldPassword") String oldPassword,
                                       @RequestParam("newPassword") String newPassword,
                                       @RequestParam("confirmPassword") String confirmPassword,
                                       RedirectAttributes redirectAttributes){
        if(!newPassword.equals(confirmPassword)){
            redirectAttributes.addFlashAttribute("messege", "Mật khẩu mới và xác nhận mật khẩu không khớp!");
            return "redirect:/admin-profile-password/" + userId;
        }
        boolean success = adminProfileService.changePassword(userId, oldPassword, newPassword);
        if (success) {
            redirectAttributes.addFlashAttribute("messege", "Đổi mật khẩu thành công!");
            return "redirect:/admin-profile/" + userId;
        }else {
            redirectAttributes.addFlashAttribute("messege", "Đổi mật khẩu thất bại vui lòng thử lại");
            return "redirect:/admin-profile-password/" + userId;
        }
    }
    @RequestMapping(value = "/admin-profile-reset", method = RequestMethod.POST)
    public String adminProfilePassword(@RequestParam("userId") int userId,
                                       @RequestParam("newPassword") String newPassword,
                                       @RequestParam("confirmPassword") String confirmPassword,
                                       RedirectAttributes redirectAttributes){
        if(!newPassword.equals(confirmPassword)){
            redirectAttributes.addFlashAttribute("messege", "Mật khẩu mới và xác nhận mật khẩu không khớp!");
            return "redirect:/admin-profile-password/" + userId;
        }
        boolean success = adminProfileService.resetPassword(userId, newPassword);
        if (success) {
            redirectAttributes.addFlashAttribute("messege", "Đổi mật khẩu thành công!");
            return "redirect:/admin-profile/" + userId;
        }else {
            redirectAttributes.addFlashAttribute("messege", "Đổi mật khẩu thất bại vui lòng thử lại");
            return "redirect:/admin-profile-password/" + userId;
        }
    }
}

