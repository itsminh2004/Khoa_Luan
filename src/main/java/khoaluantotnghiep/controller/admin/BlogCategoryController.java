package khoaluantotnghiep.controller.admin;

import khoaluantotnghiep.Dao.IBlogCategoryDao;
import khoaluantotnghiep.model.BlogCategory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/admin-blog-category")
public class BlogCategoryController {
    @Autowired
    private IBlogCategoryDao blogCategoryDao;

    @GetMapping
    public String index(Model model) {
        List<BlogCategory> categories = blogCategoryDao.findAll();
        model.addAttribute("categories", categories);
        model.addAttribute("pageTitle", "Quản lý danh mục Blog");
        return "admin/blog/category/list";
    }

    // Form thêm mới
    @GetMapping("/add")
    public String add(Model model) {
        model.addAttribute("category", new BlogCategory());
        model.addAttribute("pageTitle", "Thêm danh mục Blog");
        return "admin/blog/category/add";
    }

    // Xử lý thêm mới
    @PostMapping("/add")
    public String save(@ModelAttribute BlogCategory category, RedirectAttributes redirectAttributes) {
        try {
            blogCategoryDao.save(category);
            redirectAttributes.addFlashAttribute("success", "Thêm danh mục thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Thêm thất bại: " + e.getMessage());
        }
        return "redirect:/admin-blog-category";
    }

    // Form sửa
    @GetMapping("/edit/{id}")
    public String edit(@PathVariable int id, Model model, RedirectAttributes redirectAttributes) {
        BlogCategory category = blogCategoryDao.findById(id);
        if (category == null) {
            redirectAttributes.addFlashAttribute("error", "Không tìm thấy danh mục!");
            return "redirect:/admin/blog-category";
        }
        model.addAttribute("category", category);
        model.addAttribute("pageTitle", "Sửa danh mục Blog");
        return "admin/blog/category/edit";
    }

    // Xử lý cập nhật
    @PostMapping("/edit")
    public String update(@ModelAttribute BlogCategory category, RedirectAttributes redirectAttributes) {
        try {
            blogCategoryDao.update(category);
            redirectAttributes.addFlashAttribute("success", "Cập nhật thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Cập nhật thất bại!");
        }
        return "redirect:/admin-blog-category";
    }

    // Xóa
    @GetMapping("/delete/{id}")
    public String delete(@PathVariable int id, RedirectAttributes redirectAttributes) {
        try {
            blogCategoryDao.delete(id);
            redirectAttributes.addFlashAttribute("success", "Xóa danh mục thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Xóa thất bại! Có thể danh mục đang được sử dụng.");
        }
        return "redirect:/admin-blog-category";
    }
}
