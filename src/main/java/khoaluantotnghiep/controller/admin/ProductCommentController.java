package khoaluantotnghiep.controller.admin;

import khoaluantotnghiep.service.IProductCommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller(value = "productCommentControllerOfAdmin")
public class ProductCommentController {

    @Autowired
    private IProductCommentService commentService;

    @RequestMapping(value = "/admin-product-comment-list", method = RequestMethod.GET)
    public ModelAndView list() {
        ModelAndView mav = new ModelAndView("admin/product_comment/list");
        mav.addObject("comments", commentService.findAll());
        return mav;
    }

    @RequestMapping(value = "/admin-product-comment-reply", method = RequestMethod.POST)
    public String reply(@org.springframework.web.bind.annotation.RequestParam("parentId") int parentId,
            @org.springframework.web.bind.annotation.RequestParam("productId") int productId,
            @org.springframework.web.bind.annotation.RequestParam("comment") String commentText) {
        khoaluantotnghiep.model.ProductComment reply = new khoaluantotnghiep.model.ProductComment();
        reply.setParentId(parentId);
        reply.setProductId(productId);
        reply.setComment(commentText);
        reply.setAdminReply(true);

        // Get current logged-in user ID
        reply.setUserId(khoaluantotnghiep.utils.SecurityUtils.getCurrentUserId());

        commentService.save(reply);
        return "redirect:/admin-product-comment-list";
    }

    @RequestMapping(value = "/admin-product-comment-delete/{id}", method = RequestMethod.GET)
    public String delete(@PathVariable("id") int id) {
        commentService.delete(id);
        return "redirect:/admin-product-comment-list";
    }

}
