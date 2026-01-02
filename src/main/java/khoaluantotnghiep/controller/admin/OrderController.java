package khoaluantotnghiep.controller.admin;

import khoaluantotnghiep.model.Order;
import khoaluantotnghiep.service.IOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Arrays;
import java.util.List;

@Controller
public class OrderController {

    @Autowired
    private IOrderService orderService;

    @RequestMapping(value = "/admin-orders", method = RequestMethod.GET)
    public ModelAndView listOrders() {
        List<Order> orders = orderService.findAll();

        ModelAndView mav = new ModelAndView("admin/order/index");
        mav.addObject("orders", orders);
        mav.addObject("pageTitle", "Quản lý đơn hàng");
        return mav;
    }

    @RequestMapping(value = "/admin-orders/edit/{id}", method = RequestMethod.GET)
    public ModelAndView editOrder(@PathVariable("id") int id) {
        Order order = orderService.findById(id);
        ModelAndView mav = new ModelAndView("admin/order/edit");
        mav.addObject("order", order);
        mav.addObject("statuses", getStatuses());
        return mav;
    }

    @RequestMapping(value = "/admin-orders/edit/{id}", method = RequestMethod.POST)
    public String updateOrder(@PathVariable("id") int id,
                              @ModelAttribute("order") Order order,
                              RedirectAttributes redirectAttributes) {
        order.setId(id);
        orderService.updateOrder(order);
        redirectAttributes.addFlashAttribute("message", "Cập nhật đơn hàng #" + id + " thành công.");
        return "redirect:/admin-orders";
    }

    @RequestMapping(value = "/admin-orders/delete/{id}", method = RequestMethod.GET)
    public String deleteOrder(@PathVariable("id") int id, RedirectAttributes redirectAttributes) {
        orderService.deleteOrder(id);
        redirectAttributes.addFlashAttribute("message", "Đã xóa đơn hàng #" + id);
        return "redirect:/admin-orders";
    }

    private List<String> getStatuses() {
        return Arrays.asList("PENDING", "CONFIRMED", "SHIPPING", "DELIVERED", "CANCELLED");
    }
}

