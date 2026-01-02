package khoaluantotnghiep.api.web;

import khoaluantotnghiep.model.BlogPost;
import khoaluantotnghiep.service.IBlogPostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(origins = {"http://127.0.0.1:5500", "http://localhost:5500"}, allowCredentials = "true")
@RestController
@RequestMapping("/api/blog")
public class BlogApiController {

    @Autowired
    private IBlogPostService blogPostService;

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
}

