package khoaluantotnghiep.controller.admin;

import khoaluantotnghiep.model.Series;
import khoaluantotnghiep.service.IProductCategoryService;
import khoaluantotnghiep.service.ISeriesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class SeriesController {
    @Autowired
    private ISeriesService seriesService;
    @Autowired
    private IProductCategoryService productCategoryService;
    // 🟢 Danh sách series
    @GetMapping("/admin-series")
    public ModelAndView listSeries() {
        ModelAndView mav = new ModelAndView("admin/series/index");
        mav.addObject("seriesList", seriesService.findAll());
        return mav;
    }

    // 🟢 Trang thêm series
    @GetMapping("/admin-series-add")
    public ModelAndView addForm() {
        ModelAndView mav = new ModelAndView("admin/series/add");
        mav.addObject("series", new Series());
        mav.addObject("productCategories", productCategoryService.findAll());
        return mav;
    }

    // 🟢 Lưu series
    @PostMapping("/admin-series-add")
    public String saveSeries(@ModelAttribute("series") Series series) throws Exception {
        seriesService.insert(series);
        return "redirect:/admin-series";
    }

    @GetMapping("/admin-series/edit/{id}")
    public ModelAndView editForm(@PathVariable("id") int id) {
        ModelAndView mav = new ModelAndView("admin/series/edit");
        mav.addObject("series", seriesService.findOne(id));
        mav.addObject("productCategories", productCategoryService.findAll());
        return mav;
    }
    @PostMapping("admin-series/edit/{id}")
    public String updateSeries(@ModelAttribute("series") Series series) throws Exception{
        seriesService.update(series);
        return "redirect:/admin-series";

    }

    // 🟢 Xóa series
    @GetMapping("/admin-series/delete/{id}")
    public String deleteSeries(@PathVariable("id") int id) {
        seriesService.delete(id);
        return "redirect:/admin-series";
    }

}
