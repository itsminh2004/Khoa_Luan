package khoaluantotnghiep.controller.admin;

import khoaluantotnghiep.model.Coupon;
import khoaluantotnghiep.service.ICouponService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller(value = "couponControllerOfAdmin")
public class CouponController {

    @Autowired
    private ICouponService couponService;

    @RequestMapping(value = "/admin-coupon-list", method = RequestMethod.GET)
    public ModelAndView list() {
        ModelAndView mav = new ModelAndView("admin/coupon/list");
        mav.addObject("coupons", couponService.findAll());
        return mav;
    }

    @RequestMapping(value = "/admin-coupon-edit", method = RequestMethod.GET)
    public ModelAndView edit(@RequestParam(value = "id", required = false) Integer id) {
        ModelAndView mav = new ModelAndView("admin/coupon/edit");
        if (id != null) {
            mav.addObject("coupon", couponService.findOne(id));
        } else {
            mav.addObject("coupon", new Coupon());
        }
        return mav;
    }

    @RequestMapping(value = "/admin-coupon-edit", method = RequestMethod.POST)
    public String save(@org.springframework.web.bind.annotation.ModelAttribute("coupon") Coupon coupon) {
        couponService.save(coupon);
        return "redirect:/admin-coupon-list";
    }
    @RequestMapping(value = "/admin-coupon-delete/{id}", method = RequestMethod.GET)
    public String delete(@PathVariable("id") int id) {
        couponService.delete(id);
        return "redirect:/admin-coupon-list";
    }
}
