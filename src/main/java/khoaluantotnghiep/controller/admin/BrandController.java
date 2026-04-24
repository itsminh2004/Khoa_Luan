package khoaluantotnghiep.controller.admin;

import khoaluantotnghiep.model.Brand;
import khoaluantotnghiep.service.IBrandService;
import khoaluantotnghiep.utils.ExcelHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.List;

@Controller(value = "ControllerofBrand")
public class BrandController {
    @Autowired
    private IBrandService brandService;

    @RequestMapping(value = "/admin-brand", method = RequestMethod.GET)
    public ModelAndView homePage(@RequestParam(value = "page", defaultValue = "1") int page,
                                 @RequestParam(value = "limit", defaultValue = "10") int limit) {
        if (page < 1) page = 1;
        if (limit <= 0) limit = 10;

        int totalItem = brandService.countAll();
        int totalPage = (int) Math.ceil((double) totalItem / limit);

        if (totalPage == 0) totalPage = 1;
        if (page > totalPage) page = totalPage;

        int offset = (page - 1) * limit;

        List<Brand> brandList = brandService.findAllPaging(offset, limit);
        ModelAndView mav = new ModelAndView("/admin/brand/index");
        mav.addObject("listBrand", brandList);
        mav.addObject("page", page);
        mav.addObject("limit", limit);
        mav.addObject("totalPage", totalPage);
        mav.addObject("totalItem", totalItem);
        return mav;
    }

    @RequestMapping(value = "/admin-brand-add", method = RequestMethod.GET)
    public ModelAndView addPage() {
        ModelAndView mav = new ModelAndView("admin/brand/add");
        mav.addObject("brand", new Brand());
        return mav;
    }

    @RequestMapping(value = "/admin-brand-add", method = RequestMethod.POST)
    public String saveBrand(@ModelAttribute("brand") Brand brand,
                            @RequestParam("fileAnh") MultipartFile fileAnh, HttpServletRequest request) throws Exception {
        if (!fileAnh.isEmpty()) {
            String uploadPath = request.getServletContext().getRealPath("/uploads");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            String fileName = System.currentTimeMillis() + "_" + fileAnh.getOriginalFilename();
            File destFile = new File(uploadDir, fileName);
            fileAnh.transferTo(destFile);
            brand.setLogo("/uploads/" + fileName);
        }
        brandService.insert(brand);
        return "redirect:/admin-brand";
    }

    @RequestMapping(value = "admin-brand-edit/{id}", method = RequestMethod.GET)
    public ModelAndView editBrand(@PathVariable("id") int id) {
        Brand brand = brandService.findOne(id);
        ModelAndView mav = new ModelAndView("admin/brand/edit");
        mav.addObject("brandEdit", brand);
        return mav;
    }

    @RequestMapping(value = "admin-brand-edit/{id}", method = RequestMethod.POST)
    public String updateBrand(@PathVariable("id") int id, @ModelAttribute("brandEdit") Brand brand,
                              @RequestParam("fileAnh") MultipartFile fileAnh,
                              HttpServletRequest request) throws Exception {
        brand.setId(id);
        if (!fileAnh.isEmpty()) {
            String uploadPath = request.getServletContext().getRealPath("/uploads");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            String fileName = System.currentTimeMillis() + "_" + fileAnh.getOriginalFilename();
            File destFile = new File(uploadDir, fileName);
            fileAnh.transferTo(destFile);
            brand.setLogo("/uploads/" + fileName);
        } else {
            Brand old = brandService.findOne(id);
            brand.setLogo(old.getLogo());
        }
        brandService.update(brand);
        return "redirect:/admin-brand";
    }

    @RequestMapping(value = "admin-brand-delete/{id}", method = RequestMethod.GET)
    public String deleteBrand(@PathVariable("id") int id) {
        brandService.delete(id);
        return "redirect:/admin-brand";
    }
    @RequestMapping(value = "/admin-brand-import", method = RequestMethod.POST)
    public String importExcel(@RequestParam("fileExcel") MultipartFile file) {
        if (ExcelHelper.hasExcelFormat(file)) {
            try {
                List<Brand> items = ExcelHelper.excelToBrands(file.getInputStream());
                brandService.saveAll(items);
                return "redirect:/admin-brand?importSuccess=true";
            } catch (Exception e) {
                return "redirect:/admin-brand?importError=" + e.getMessage();
            }
        }
        return "redirect:/admin-brand?importError=InvalidFormat";
    }
    @RequestMapping(value = "/admin-brand-export", method = RequestMethod.GET)
    public org.springframework.http.ResponseEntity<org.springframework.core.io.Resource> exportExcel() {
        String filename = "brands_" + System.currentTimeMillis() + ".xlsx";
        org.springframework.core.io.InputStreamResource file = new org.springframework.core.io.InputStreamResource(ExcelHelper.brandsToExcel(brandService.findAll()));

        return org.springframework.http.ResponseEntity.ok()
                .header(org.springframework.http.HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=" + filename)
                .contentType(org.springframework.http.MediaType.parseMediaType(ExcelHelper.TYPE))
                .body(file);
    }
}
