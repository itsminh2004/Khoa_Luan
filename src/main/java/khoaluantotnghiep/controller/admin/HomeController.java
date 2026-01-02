package khoaluantotnghiep.controller.admin;

import khoaluantotnghiep.service.IOrderService;
import khoaluantotnghiep.service.IProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.Calendar;

@Controller(value = "homeControllerOfAdmin")
public class HomeController {

    @Autowired
    private IOrderService orderService;

    @Autowired
    private IProductService productService;

    @RequestMapping(value = "/admin-home", method = RequestMethod.GET)
    public ModelAndView homePage() {
        ModelAndView mav = new ModelAndView("/admin/home");

        // Lấy thống kê
        long totalOrders = orderService.getTotalOrders();
        int totalProducts = productService.countAll();

        // Lấy doanh thu tháng hiện tại
        Calendar cal = Calendar.getInstance();
        int currentYear = cal.get(Calendar.YEAR);
        int currentMonth = cal.get(Calendar.MONTH) + 1; // Calendar.MONTH bắt đầu từ 0
        double monthlyRevenue = orderService.getMonthlyRevenue(currentYear, currentMonth);

        // Truyền dữ liệu vào view
        mav.addObject("totalOrders", totalOrders);
        mav.addObject("totalProducts", totalProducts);
        mav.addObject("monthlyRevenue", monthlyRevenue);
        mav.addObject("currentYear", currentYear);
        mav.addObject("currentMonth", currentMonth);

        return mav;
    }

    @RequestMapping(value = "/admin-revenue", method = RequestMethod.GET)
    public ModelAndView revenuePage(@RequestParam(value = "year", required = false) Integer year,
                                    @RequestParam(value = "month", required = false) Integer month) {
        ModelAndView mav = new ModelAndView("/admin/revenue");

        Calendar cal = Calendar.getInstance();
        int currentYear = cal.get(Calendar.YEAR);
        int currentMonth = cal.get(Calendar.MONTH) + 1;

        // Nếu không có tham số, dùng tháng hiện tại
        if (year == null) year = currentYear;
        if (month == null) month = currentMonth;

        // Lấy doanh thu tháng được chọn
        double monthlyRevenue = orderService.getMonthlyRevenue(year, month);

        // Lấy doanh thu các tháng gần đây (6 tháng gần nhất)
        java.util.List<java.util.Map<String, Object>> recentMonths = new java.util.ArrayList<>();
        for (int i = 5; i >= 0; i--) {
            Calendar monthCal = Calendar.getInstance();
            monthCal.add(Calendar.MONTH, -i);
            int mYear = monthCal.get(Calendar.YEAR);
            int mMonth = monthCal.get(Calendar.MONTH) + 1;
            double revenue = orderService.getMonthlyRevenue(mYear, mMonth);

            java.util.Map<String, Object> monthData = new java.util.HashMap<>();
            monthData.put("year", mYear);
            monthData.put("month", mMonth);
            monthData.put("revenue", revenue);
            monthData.put("monthName", getMonthName(mMonth));
            recentMonths.add(monthData);
        }

        mav.addObject("selectedYear", year);
        mav.addObject("selectedMonth", month);
        mav.addObject("monthlyRevenue", monthlyRevenue);
        mav.addObject("recentMonths", recentMonths);
        mav.addObject("currentYear", currentYear);
        mav.addObject("currentMonth", currentMonth);

        return mav;
    }

    private String getMonthName(int month) {
        String[] months = {"", "Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4", "Tháng 5", "Tháng 6",
                "Tháng 7", "Tháng 8", "Tháng 9", "Tháng 10", "Tháng 11", "Tháng 12"};
        return months[month];
    }

}