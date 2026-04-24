package khoaluantotnghiep.api.web;

import khoaluantotnghiep.model.Coupon;
import khoaluantotnghiep.model.Policy;
import khoaluantotnghiep.service.ICouponService;
import khoaluantotnghiep.service.IPolicyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@CrossOrigin(origins = { "http://localhost:5500", "http://127.0.0.1:5500" })
@RestController
@RequestMapping("/api")
public class UtilityApiController {

    @Autowired
    private IPolicyService policyService;

    @Autowired
    private ICouponService couponService;

    // ✅ Lấy toàn bộ chính sách
    @GetMapping(value = "/policies", produces = "application/json; charset=UTF-8")
    public List<Policy> listPolicies() {
        return policyService.findAll();
    }

    // ✅ Lấy chi tiết chính sách theo slug
    @GetMapping(value = "/policies/{slug}", produces = "application/json; charset=UTF-8")
    public Policy getPolicy(@PathVariable("slug") String slug) {
        return policyService.findBySlug(slug);
    }

    @GetMapping(value = "/coupons", produces = "application/json;charset=UTF-8")
    public List<Coupon> getValidCoupons() {
        Date now = new Date();
        return couponService.findAll().stream()
                .filter(Coupon::isStatus)  // hoặc .filter(c -> Boolean.TRUE.equals(c.getActive()))
                .filter(c -> {
                    boolean startOk = c.getStartDate() == null || !now.before(c.getStartDate());
                    boolean endOk   = c.getEndDate()   == null || !now.after(c.getEndDate());
                    return startOk && endOk;
                })
                .collect(Collectors.toList());
    }

    @GetMapping(value = "/coupons/check", produces = "application/json;charset=UTF-8")
    public ResponseEntity<Map<String, Object>> checkCoupon(
            @RequestParam("code") String code,
            @RequestParam(value = "amount", defaultValue = "0") double amount) {

        Map<String, Object> response = new HashMap<>();

        if (amount <= 0) {
            response.put("valid", false);
            response.put("message", "Số tiền đơn hàng không hợp lệ.");
            return ResponseEntity.badRequest().body(response);
        }

        if (!couponService.isValid(code, amount)) {
            response.put("valid", false);
            response.put("message", "Mã giảm giá không hợp lệ hoặc không đủ điều kiện.");
            return ResponseEntity.ok(response);
        }

        Coupon coupon = couponService.findByCode(code);
        if (coupon == null) {
            response.put("valid", false);
            response.put("message", "Mã giảm giá không tồn tại.");
            return ResponseEntity.ok(response);
        }

        double actualDiscount = calculateDiscount(coupon, amount);

        response.put("valid", true);
        response.put("code", coupon.getCode());
        response.put("couponId", coupon.getId());
        response.put("discount", actualDiscount);
        response.put("discountType", coupon.getDiscountType());
        response.put("discountValue", coupon.getDiscountValue());
        response.put("message", "Áp dụng mã giảm giá thành công!");

        return ResponseEntity.ok(response);
    }

    private double calculateDiscount(Coupon coupon, double orderAmount) {
        if (coupon == null) return 0;

        double discount = 0;
        String type = coupon.getDiscountType();

        if ("PERCENT".equalsIgnoreCase(type)) {
            discount = orderAmount * (coupon.getDiscountValue() / 100.0);
            if (coupon.getMaxDiscountAmount() != null && discount > coupon.getMaxDiscountAmount()) {
                discount = coupon.getMaxDiscountAmount();
            }
        } else if ("AMOUNT".equalsIgnoreCase(type)) {
            discount = coupon.getDiscountValue();
        }

        return Math.max(0, discount); // tránh âm
    }
}