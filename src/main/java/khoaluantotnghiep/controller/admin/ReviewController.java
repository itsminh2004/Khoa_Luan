package khoaluantotnghiep.controller.admin;

import khoaluantotnghiep.service.IProductReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller(value = "reviewControllerOfAdmin")
public class ReviewController {

    @Autowired
    private IProductReviewService reviewService;

    @RequestMapping(value = "/admin-review-list", method = RequestMethod.GET)
    public ModelAndView list() {
        ModelAndView mav = new ModelAndView("admin/review/list");
        mav.addObject("reviews", reviewService.findAll());
        return mav;
    }

    @RequestMapping(value = "/admin-review-delete/{id}", method = RequestMethod.GET)
    public String delete(@PathVariable("id") int id) {
        reviewService.delete(id);
        return "redirect:/admin-review-list";
    }
}
