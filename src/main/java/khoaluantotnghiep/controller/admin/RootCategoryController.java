package khoaluantotnghiep.controller.admin;

import khoaluantotnghiep.model.RootCategory;
import khoaluantotnghiep.service.IRootCategoryService;
import khoaluantotnghiep.utils.ExcelHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.List;

@Controller
public class RootCategoryController {

    @Autowired
    private IRootCategoryService rootCategoryService;

    @RequestMapping(value = "/admin-root-category", method = RequestMethod.GET)
    public ModelAndView homePage(@RequestParam(value = "page", defaultValue = "1") int page,
                                 @RequestParam(value = "limit", defaultValue = "10") int limit) {
        int totalItem = rootCategoryService.countAll();
        int totalPage = (int) Math.ceil((double) totalItem / limit);
        if (totalPage == 0)
            totalPage = 1;

        int offset = (page - 1) * limit;
        List<RootCategory> list = rootCategoryService.findAllPaging(offset, limit);

        ModelAndView mav = new ModelAndView("admin/root-category/index");
        mav.addObject("listRootCategory", list);
        mav.addObject("page", page);
        mav.addObject("totalPage", totalPage);
        return mav;
    }

    @RequestMapping(value = "/admin-root-category-add", method = RequestMethod.GET)
    public ModelAndView addPage() {
        ModelAndView mav = new ModelAndView("admin/root-category/add");
        mav.addObject("rootCategory", new RootCategory());
        return mav;
    }

    @RequestMapping(value = "/admin-root-category-add", method = RequestMethod.POST)
    public String save(@ModelAttribute("rootCategory") RootCategory rootCategory,
                       @RequestParam("fileAnh") MultipartFile fileAnh, HttpServletRequest request) throws Exception {
        handleImageUpload(rootCategory, fileAnh, request);
        rootCategoryService.save(rootCategory);
        return "redirect:/admin-root-category";
    }

    @RequestMapping(value = "/admin-root-category-edit/{id}", method = RequestMethod.GET)
    public ModelAndView editPage(@PathVariable("id") int id) {
        RootCategory category = rootCategoryService.findOne(id);
        ModelAndView mav = new ModelAndView("admin/root-category/edit");
        mav.addObject("rootCategoryEdit", category);
        return mav;
    }

    @RequestMapping(value = "/admin-root-category-edit/{id}", method = RequestMethod.POST)
    public String update(@PathVariable("id") int id,
                         @ModelAttribute("rootCategoryEdit") RootCategory rootCategory,
                         @RequestParam("fileAnh") MultipartFile fileAnh, HttpServletRequest request) throws Exception {
        RootCategory old = rootCategoryService.findOne(id);
        if (!fileAnh.isEmpty()) {
            handleImageUpload(rootCategory, fileAnh, request);
        } else {
            rootCategory.setImage(old.getImage());
        }
        rootCategory.setId(id);
        rootCategoryService.update(rootCategory);
        return "redirect:/admin-root-category";
    }

    @RequestMapping(value = "/admin-root-category-delete/{id}", method = RequestMethod.GET)
    public String delete(@PathVariable("id") int id) {
        rootCategoryService.delete(id);
        return "redirect:/admin-root-category";
    }
    @RequestMapping(value = "/admin-root-category-import", method = RequestMethod.POST)
    public String importExcel(@RequestParam("fileExcel") MultipartFile file) {
        if (ExcelHelper.hasExcelFormat(file)) {
            try {
                List<RootCategory> items = ExcelHelper.excelToRootCategories(file.getInputStream());
                rootCategoryService.saveAll(items);
                return "redirect:/admin-root-category?importSuccess=true";
            } catch (Exception e) {
                return "redirect:/admin-root-category?importError=" + e.getMessage();
            }
        }
        return "redirect:/admin-root-category?importError=InvalidFormat";
    }
    @RequestMapping(value = "/admin-root-category-export", method = RequestMethod.GET)
    public org.springframework.http.ResponseEntity<org.springframework.core.io.Resource> exportExcel() {
        String filename = "root_categories_" + System.currentTimeMillis() + ".xlsx";
        org.springframework.core.io.InputStreamResource file = new org.springframework.core.io.InputStreamResource(ExcelHelper.rootCategoriesToExcel(rootCategoryService.findAll()));

        return org.springframework.http.ResponseEntity.ok()
                .header(org.springframework.http.HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=" + filename)
                .contentType(org.springframework.http.MediaType.parseMediaType(ExcelHelper.TYPE))
                .body(file);
    }
    private void handleImageUpload(RootCategory category, MultipartFile fileAnh, HttpServletRequest request)
            throws Exception {
        if (!fileAnh.isEmpty()) {
            String uploadPath = request.getServletContext().getRealPath("/uploads");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists())
                uploadDir.mkdirs();
            String fileName = System.currentTimeMillis() + "_" + fileAnh.getOriginalFilename();
            File destFile = new File(uploadDir, fileName);
            fileAnh.transferTo(destFile);
            category.setImage("/uploads/" + fileName);
        }
    }
}
