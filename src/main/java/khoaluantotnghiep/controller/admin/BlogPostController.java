package khoaluantotnghiep.controller.admin;

import khoaluantotnghiep.model.BlogPost;
import khoaluantotnghiep.model.User;
import khoaluantotnghiep.service.IBlogCategoryService;
import khoaluantotnghiep.service.IBlogPostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;

@Controller
@RequestMapping("/admin-blog-post")
public class BlogPostController {
    @Autowired
    private IBlogPostService blogPostService;

    @Autowired
    private IBlogCategoryService blogCategoryService;

    // Danh sách bài viết
    @GetMapping
    public String index(Model model) {
        model.addAttribute("posts", blogPostService.findAll());
        model.addAttribute("pageTitle", "Quản lý bài viết Blog");
        return "admin/blog/post/list";
    }

    // Form thêm mới
    @GetMapping("/add")
    public String add(Model model) {
        model.addAttribute("post", new BlogPost());
        model.addAttribute("categories", blogCategoryService.findAll());
        model.addAttribute("pageTitle", "Viết bài mới");
        return "admin/blog/post/add";
    }

    // Xử lý thêm
    @PostMapping("/add")
    public String save(
            @ModelAttribute BlogPost post,
            @RequestParam(value = "thumbnailFile", required = false) MultipartFile thumbnailFile,
            HttpServletRequest request,
            RedirectAttributes ra,
            HttpSession session
    ) {
        try {
            User currentUser = (User) session.getAttribute("user");
            if (currentUser == null) {
                ra.addFlashAttribute("error", "Phiên đăng nhập đã hết hạn, vui lòng đăng nhập lại.");
                return "redirect:/login";
            }

            if (!isValidPost(post)) {
                ra.addFlashAttribute("error", "Vui lòng điền đầy đủ tiêu đề, nội dung và chọn danh mục.");
                return "redirect:/admin-blog-post/add";
            }

            post.setAuthorId(currentUser.getId());

            if (post.getStatus() == null || post.getStatus().trim().isEmpty()) {
                post.setStatus("DRAFT");
            }

            if (thumbnailFile != null && !thumbnailFile.isEmpty()) {
                String uploadPath = request.getServletContext().getRealPath("/uploads");
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();

                String fileName = System.currentTimeMillis() + "_" + thumbnailFile.getOriginalFilename();
                File destFile = new File(uploadDir, fileName);
                thumbnailFile.transferTo(destFile);
                post.setThumbnail("/uploads/" + fileName);
            }

            blogPostService.save(post);
            ra.addFlashAttribute("success", "Thêm bài viết thành công! ID = " + post.getId());

        } catch (Exception e) {
            e.printStackTrace();
            ra.addFlashAttribute("error", "Lưu thất bại: " + e.getMessage());
        }
        return "redirect:/admin-blog-post";
    }

    // Form sửa
    @GetMapping("/edit/{id}")
    public String edit(@PathVariable int id, Model model, RedirectAttributes ra) {
        BlogPost post = blogPostService.findById(id);
        if (post == null) {
            ra.addFlashAttribute("error", "Bài viết không tồn tại!");
            return "redirect:/admin-blog-post";
        }
        model.addAttribute("post", post);
        model.addAttribute("categories", blogCategoryService.findAll());
        model.addAttribute("pageTitle", "Sửa bài viết");
        return "admin/blog/post/edit";
    }

    // Xử lý cập nhật
    @PostMapping("/edit")
    public String update(
            @ModelAttribute BlogPost post,
            @RequestParam(value = "thumbnailFile", required = false) MultipartFile thumbnailFile,
            HttpServletRequest request,
            RedirectAttributes ra
    ) {
        try {
            if (post.getId() == null) {
                ra.addFlashAttribute("error", "Thiếu thông tin bài viết cần cập nhật.");
                return "redirect:/admin-blog-post";
            }

            if (!isValidPost(post)) {
                ra.addFlashAttribute("error", "Vui lòng điền đầy đủ tiêu đề, nội dung và chọn danh mục.");
                return "redirect:/admin-blog-post/edit/" + post.getId();
            }

            BlogPost old = blogPostService.findById(post.getId());

            if (thumbnailFile != null && !thumbnailFile.isEmpty()) {
                String uploadPath = request.getServletContext().getRealPath("/uploads");
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();

                String fileName = System.currentTimeMillis() + "_" + thumbnailFile.getOriginalFilename();
                File destFile = new File(uploadDir, fileName);
                thumbnailFile.transferTo(destFile);
                post.setThumbnail("/uploads/" + fileName);
            } else {
                if (old != null && (post.getThumbnail() == null || post.getThumbnail().trim().isEmpty())) {
                    post.setThumbnail(old.getThumbnail());
                }
            }

            blogPostService.update(post);
            ra.addFlashAttribute("success", "Cập nhật bài viết thành công!");
        } catch (Exception e) {
            e.printStackTrace();
            ra.addFlashAttribute("error", "Cập nhật thất bại!");
        }
        return "redirect:/admin-blog-post";
    }

    // Xóa bài viết
    @GetMapping("/delete/{id}")
    public String delete(@PathVariable int id, RedirectAttributes ra) {
        try {
            blogPostService.delete(id);
            ra.addFlashAttribute("success", "Xóa bài viết thành công!");
        } catch (Exception e) {
            ra.addFlashAttribute("error", "Không thể xóa bài viết!");
        }
        return "redirect:/admin-blog-post";
    }

    // Đổi trạng thái (xuất bản / nháp)
    @GetMapping("/toggle-status/{id}")
    public String toggleStatus(@PathVariable int id, RedirectAttributes ra) {
        BlogPost post = blogPostService.findById(id);
        if (post != null) {
            post.setStatus("PUBLISHED".equals(post.getStatus()) ? "DRAFT" : "PUBLISHED");
            blogPostService.update(post);
            ra.addFlashAttribute("success", "Đổi trạng thái thành công!");
        } else {
            ra.addFlashAttribute("error", "Không tìm thấy bài viết để cập nhật trạng thái.");
        }
        return "redirect:/admin-blog-post";
    }

    private boolean isValidPost(BlogPost post) {
        boolean hasTitle = post.getTitle() != null && !post.getTitle().trim().isEmpty();
        boolean hasContent = post.getContent() != null && !post.getContent().trim().isEmpty();
        boolean hasCategory = post.getCategoryId() != null && post.getCategoryId() > 0;
        return hasTitle && hasContent && hasCategory;
    }
}
