package khoaluantotnghiep.controller.admin;

import khoaluantotnghiep.model.BlogComment;
import khoaluantotnghiep.service.IBlogCommentService;
import khoaluantotnghiep.service.IBlogPostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/admin-blog-comment")
public class BlogCommentController {

    @Autowired
    private IBlogCommentService commentService;

    @Autowired
    private IBlogPostService postService;

    // Danh sách tất cả comment (hoặc có thể lọc theo bài viết)
    @GetMapping
    public String index(@RequestParam(value = "postId", required = false) Integer postId, Model model) {
        List<BlogComment> comments =
                (postId != null && postId > 0)
                        ? commentService.findByPostId(postId)
                        : commentService.findAllWithDetails();

        model.addAttribute("comments", comments);
        model.addAttribute("posts", postService.findAll());
        model.addAttribute("selectedPostId", postId);
        model.addAttribute("pageTitle", "Quản lý bình luận Blog");
        return "admin/blog/comment/list";
    }

    // Xóa bình luận
    @GetMapping("/delete/{id}")
    public String delete(@PathVariable int id,
                         @RequestParam(required = false) Integer postId,
                         RedirectAttributes ra) {
        try {
            commentService.delete(id);
            ra.addFlashAttribute("success", "Xóa bình luận thành công!");
        } catch (Exception e) {
            ra.addFlashAttribute("error", "Xóa bình luận thất bại!");
        }

        if (postId != null) {
            return "redirect:/admin/blog-post/edit/" + postId;
        }
        return "redirect:/admin-blog-comment";
    }
}
