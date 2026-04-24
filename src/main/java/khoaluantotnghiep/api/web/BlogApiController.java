package khoaluantotnghiep.api.web;

import khoaluantotnghiep.dto.BlogCommentDto;
import khoaluantotnghiep.model.BlogPost;
import khoaluantotnghiep.model.BlogCategory;
import khoaluantotnghiep.model.BlogComment;
import khoaluantotnghiep.model.User;
import khoaluantotnghiep.service.IBlogPostService;
import khoaluantotnghiep.service.IBlogCategoryService;
import khoaluantotnghiep.service.IBlogCommentService;
import khoaluantotnghiep.service.impl.CustomUserDetails;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.*;

import java.util.List;

import static java.lang.System.err;

@CrossOrigin(origins = {"http://127.0.0.1:5500", "http://localhost:5500"}, allowCredentials = "true")
@RestController
@RequestMapping("/api/blog")
public class BlogApiController {

    @Autowired
    private IBlogPostService blogPostService;
    @Autowired
    private IBlogCategoryService blogCategoryService;
    @Autowired
    private IBlogCommentService blogCommentService;

    // Lấy tất cả bài viết đã xuất bản
    @GetMapping(value = "/posts", produces = "application/json; charset=UTF-8")
    public ResponseEntity<List<BlogPost>> getAllPublishedPosts() {
        try {
            List<BlogPost> posts = blogPostService.findAllPublished();
            return ResponseEntity.ok(posts);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    // Lấy bài viết theo ID
    @GetMapping(value = "/posts/{id}", produces = "application/json; charset=UTF-8")
    public ResponseEntity<BlogPost> getPostById(@PathVariable int id) {
        try {
            BlogPost post = blogPostService.findById(id);
            if (post != null && "PUBLISHED".equals(post.getStatus())) {
                return ResponseEntity.ok(post);
            }
            return ResponseEntity.notFound().build();
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    // Lấy bài viết theo slug
    @GetMapping(value = "/posts/slug/{slug}", produces = "application/json; charset=UTF-8")
    public ResponseEntity<BlogPost> getPostBySlug(@PathVariable String slug) {
        try {
            BlogPost post = blogPostService.findBySlug(slug);
            if (post != null && "PUBLISHED".equals(post.getStatus())) {
                return ResponseEntity.ok(post);
            }
            return ResponseEntity.notFound().build();
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    // Lấy bài viết theo danh mục
    @GetMapping(value = "/posts/category/{categoryId}", produces = "application/json; charset=UTF-8")
    public ResponseEntity<List<BlogPost>> getPostsByCategory(@PathVariable int categoryId) {
        try {
            List<BlogPost> allPosts = blogPostService.findAllPublished();
            List<BlogPost> filteredPosts = allPosts.stream()
                    .filter(p -> p.getCategoryId() != null && p.getCategoryId().equals(categoryId))
                    .collect(java.util.stream.Collectors.toList());
            return ResponseEntity.ok(filteredPosts);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
    @GetMapping(value = "/categories", produces = "application/json; charset=UTF-8")
    public ResponseEntity<List<BlogCategory>> getAllCategories() {
        try {
            List<BlogCategory> categories = blogCategoryService.findAll();
            return ResponseEntity.ok(categories);
        }catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
    @GetMapping(value = "/posts/{postId}/comments", produces = "application/json; charset=UTF-8")
    public ResponseEntity<List<BlogComment>> getPostComments(@PathVariable int postId) {
        try {
            List<BlogComment> comments = blogCommentService.findByPostId(postId);
            return ResponseEntity.ok(comments);
        }catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
    @PostMapping(value = "/posts/{postId}/comments", produces = "application/json; charset= UTF-8")
    public ResponseEntity<?> createComment(@PathVariable int postId ,
                                           @Valid @RequestBody BlogCommentDto dto,
                                           BindingResult result) {
        if (result.hasErrors()) {
            Map<String, String> errors = new HashMap<>();
            result.getFieldErrors().forEach(err-> errors.put(err.getField(), err.getDefaultMessage()));
            return ResponseEntity.badRequest().body(errors);
        }

        BlogComment comment = new BlogComment();
        comment.setPostId(postId);
        comment.setUserId(dto.getUserId());
        comment.setComment(dto.getComment().trim());
        comment.setCreatedAt(new Date());

        BlogComment savedComment = blogCommentService.save(comment);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedComment);
    }
    @DeleteMapping(value = "/comments/{commentId}", produces = "application/json; charset=UTF-8")
    public ResponseEntity<?> deleteComment(@PathVariable int commentId) {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if (authentication == null || !authentication.isAuthenticated()
                || "anonymousUser".equals(authentication.getPrincipal())) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body(Collections.singletonMap("error", "Bạn chưa đăng nhập"));
        }

        CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
        User currentUser = userDetails.getUser();

        BlogComment comment = blogCommentService.findById(commentId);
        if (comment == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(Collections.singletonMap("error", "Không tìm thấy bình luận"));
        }

        boolean isOwner = comment.getUserId().equals(currentUser.getId());
        boolean isAdmin = currentUser.getRoles().contains("ROLE_ADMIN");

        if (!isOwner && !isAdmin) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN)
                    .body(Collections.singletonMap("error", "Bạn không có quyền xóa bình luận này"));
        }

        blogCommentService.delete(commentId);
        return ResponseEntity.ok(Collections.singletonMap("message", "Xóa bình luận thành công"));
    }

}

