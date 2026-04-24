package khoaluantotnghiep.controller.admin;

import khoaluantotnghiep.model.Banner;
import khoaluantotnghiep.service.IBannerService;
import khoaluantotnghiep.service.IProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Controller
@RequestMapping("/admin/banners")
public class BannerController {

    @Autowired
    private IBannerService bannerService;

    @Autowired
    private IProductService productService;

    @RequestMapping(method = RequestMethod.GET)
    public String list(
            @RequestParam(value = "position", required = false) String position,
            @RequestParam(value = "active", required = false) String activeParam,
            Model model) {

        Boolean activeFilter = null;
        if (activeParam != null && !activeParam.trim().isEmpty()) {
            if ("1".equals(activeParam) || "true".equalsIgnoreCase(activeParam)) {
                activeFilter = true;
            } else if ("0".equals(activeParam) || "false".equalsIgnoreCase(activeParam)) {
                activeFilter = false;
            }
        }

        List<Banner> banners = bannerService.findAllWithProduct(position, activeFilter);
        model.addAttribute("banners", banners);

        model.addAttribute("filterPosition", position);
        model.addAttribute("filterActive", activeParam);
        return "admin/banner/list";
    }

    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String addForm(Model model) {
        Banner banner = new Banner();
        banner.setActive(true);
        banner.setPosition("HOME_HERO");
        banner.setSortOrder(0);

        model.addAttribute("banner", banner);
        model.addAttribute("products", productService.findAll());
        return "admin/banner/form";
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String add(
            @ModelAttribute Banner banner,
            @RequestParam(value = "imageFile", required = false) MultipartFile imageFile,
            @RequestParam(value = "image_url", required = false) String imageUrlHidden,
            RedirectAttributes redirectAttributes,
            HttpServletRequest request) {

        try {
            // Field hidden theo đúng tên column: image_url
            banner.setImageUrl(imageUrlHidden);
            validateBannerForSave(banner, true);
            if (imageFile == null || imageFile.isEmpty()) {
                throw new IllegalArgumentException("Vui lòng chọn ảnh banner.");
            }

            String uploadUrl = saveBannerImage(imageFile, request);
            banner.setImageUrl(uploadUrl);

            if (banner.getSortOrder() < 0) {
                banner.setSortOrder(0);
            }

            bannerService.save(banner);
            redirectAttributes.addFlashAttribute("success", "Thêm banner thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Thêm banner thất bại: " + e.getMessage());
            return "redirect:/admin/banners/add";
        }

        return "redirect:/admin/banners";
    }

    @RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
    public String editForm(@PathVariable("id") int id, Model model, RedirectAttributes redirectAttributes) {
        Banner banner = bannerService.findOne(id);
        if (banner == null) {
            redirectAttributes.addFlashAttribute("error", "Không tìm thấy banner!");
            return "redirect:/admin/banners";
        }
        model.addAttribute("banner", banner);
        model.addAttribute("products", productService.findAll());
        return "admin/banner/form";
    }

    @RequestMapping(value = "/edit/{id}", method = RequestMethod.POST)
    public String edit(
            @PathVariable("id") int id,
            @ModelAttribute Banner banner,
            @RequestParam(value = "imageFile", required = false) MultipartFile imageFile,
            @RequestParam(value = "image_url", required = false) String imageUrlHidden,
            RedirectAttributes redirectAttributes,
            HttpServletRequest request) {

        try {
            banner.setId(id);
            // Field hidden theo đúng tên column: image_url
            banner.setImageUrl(imageUrlHidden);
            validateBannerForSave(banner, false);

            // Upload nếu chọn ảnh mới
            if (imageFile != null && !imageFile.isEmpty()) {
                String uploadUrl = saveBannerImage(imageFile, request);
                banner.setImageUrl(uploadUrl);
            } else {
                // Không upload: bắt buộc banner.imageUrl từ hidden (edit form)
                if (banner.getImageUrl() == null || banner.getImageUrl().trim().isEmpty()) {
                    throw new IllegalArgumentException("Ảnh banner không hợp lệ.");
                }
            }

            if (banner.getSortOrder() < 0) {
                banner.setSortOrder(0);
            }

            bannerService.update(banner);
            redirectAttributes.addFlashAttribute("success", "Cập nhật banner thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Cập nhật banner thất bại: " + e.getMessage());
            return "redirect:/admin/banners/edit/" + id;
        }

        return "redirect:/admin/banners";
    }

    @RequestMapping(value = "/delete/{id}", method = RequestMethod.POST)
    public String delete(@PathVariable("id") int id, RedirectAttributes redirectAttributes) {
        try {
            bannerService.delete(id);
            redirectAttributes.addFlashAttribute("success", "Xóa banner thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Xóa banner thất bại: " + e.getMessage());
        }
        return "redirect:/admin/banners";
    }

    @RequestMapping(value = "/toggle/{id}", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> toggle(@PathVariable("id") int id) {
        Map<String, Object> res = new HashMap<>();
        try {
            boolean newActive = bannerService.toggleActive(id);
            res.put("success", true);
            res.put("active", newActive);
        } catch (Exception e) {
            res.put("success", false);
            res.put("message", e.getMessage());
        }
        return res;
    }

    private void validateBannerForSave(Banner banner, boolean isAdd) {
        if (banner.getTitle() == null || banner.getTitle().trim().isEmpty()) {
            throw new IllegalArgumentException("Tiêu đề banner không được để trống.");
        }
        if (banner.getPosition() == null || banner.getPosition().trim().isEmpty()) {
            throw new IllegalArgumentException("Vị trí (position) không được để trống.");
        }

        Set<String> allowedPositions = new HashSet<>(Arrays.asList("HOME_HERO", "HOME_SUB", "POPUP"));
        if (!allowedPositions.contains(banner.getPosition())) {
            throw new IllegalArgumentException("position không hợp lệ.");
        }

        if (!isAdd) {
            // Edit: ảnh được truyền qua hidden imageUrl (hidden bắt buộc trong form.jsp)
            if (banner.getImageUrl() == null || banner.getImageUrl().trim().isEmpty()) {
                // trường hợp edit có upload file mới thì imageUrl sẽ được set lại ở phía sau
                // nên chỉ check khi không upload.
                // (ở luồng edit() mình check tiếp khi file rỗng)
            }
        }
    }

    private String saveBannerImage(MultipartFile file, HttpServletRequest request) throws Exception {
        if (file == null || file.isEmpty()) {
            throw new IllegalArgumentException("Ảnh banner không hợp lệ.");
        }

        long maxSize = 5L * 1024L * 1024L;
        if (file.getSize() > maxSize) {
            throw new IllegalArgumentException("Dung lượng ảnh vượt quá 5MB.");
        }

        String originalFilename = file.getOriginalFilename();
        if (originalFilename == null) {
            throw new IllegalArgumentException("Tên file ảnh không hợp lệ.");
        }

        String lower = originalFilename.toLowerCase();
        boolean extOk = lower.endsWith(".jpg") || lower.endsWith(".jpeg") || lower.endsWith(".png") || lower.endsWith(".webp");
        if (!extOk) {
            throw new IllegalArgumentException("Chỉ hỗ trợ định dạng jpg, png, webp.");
        }

        String contentType = file.getContentType();
        if (contentType != null && !contentType.toLowerCase().startsWith("image/")) {
            throw new IllegalArgumentException("File không phải ảnh hợp lệ.");
        }

        String uploadPath = request.getServletContext().getRealPath("/uploads");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        String safeOriginal = originalFilename.replaceAll("[\\\\/]", "_");
        String fileName = System.currentTimeMillis() + "_" + safeOriginal;

        File destFile = new File(uploadDir, fileName);
        file.transferTo(destFile);

        return "/uploads/" + fileName;
    }
}

