package khoaluantotnghiep.controller.admin;

import khoaluantotnghiep.model.Series;
import khoaluantotnghiep.service.IProductCategoryService;
import khoaluantotnghiep.service.ISeriesService;
import khoaluantotnghiep.utils.ExcelHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
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
    @RequestMapping(value = "/admin-series-import", method = RequestMethod.POST)
    public String importExcel(@RequestParam("fileExcel") MultipartFile file) {
        if (ExcelHelper.hasExcelFormat(file)) {
            try {
                java.util.List<Series> items = ExcelHelper.excelToSeries(file.getInputStream());
                seriesService.saveAll(items);
                return "redirect:/admin-series?importSuccess=true";
            } catch (Exception e) {
                return "redirect:/admin-series?importError=" + e.getMessage();
            }
        }
        return "redirect:/admin-series?importError=InvalidFormat";
    }
    @RequestMapping(value = "/admin-series-export", method = RequestMethod.GET)
    public org.springframework.http.ResponseEntity<org.springframework.core.io.Resource> exportExcel() {
        String filename = "series_" + System.currentTimeMillis() + ".xlsx";
        org.springframework.core.io.InputStreamResource file = new org.springframework.core.io.InputStreamResource(ExcelHelper.seriesToExcel(seriesService.findAll()));

        return org.springframework.http.ResponseEntity.ok()
                .header(org.springframework.http.HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=" + filename)
                .contentType(org.springframework.http.MediaType.parseMediaType(ExcelHelper.TYPE))
                .body(file);
    }

}
