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

import javax.servlet.http.HttpSession;

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
    public String save(@ModelAttribute BlogPost post, RedirectAttributes ra, HttpSession session) {
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
    public String update(@ModelAttribute BlogPost post, RedirectAttributes ra) {
        try {
            if (post.getId() == null) {
                ra.addFlashAttribute("error", "Thiếu thông tin bài viết cần cập nhật.");
                return "redirect:/admin-blog-post";
            }

            if (!isValidPost(post)) {
                ra.addFlashAttribute("error", "Vui lòng điền đầy đủ tiêu đề, nội dung và chọn danh mục.");
                return "redirect:/admin-blog-post/edit/" + post.getId();
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
