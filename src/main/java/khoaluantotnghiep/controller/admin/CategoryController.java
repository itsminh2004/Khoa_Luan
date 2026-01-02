package khoaluantotnghiep.controller.admin;

import khoaluantotnghiep.model.ProductCategory;
import khoaluantotnghiep.service.IProductCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.List;


@Controller(value = "ControllerofCategory")
public class CategoryController {
    @Autowired
    private IProductCategoryService productCategoryService;



    @RequestMapping(value = "/admin-category", method = RequestMethod.GET)
    public ModelAndView homePage( @RequestParam(value = "page", defaultValue = "1")int page,
                                  @RequestParam(value = "limit", defaultValue = "10")int limit) {
        if(page<1) page=1;
        if(limit<=0) limit=10;

        int totalItem= productCategoryService.countAll();
        int totalPage=(int) Math.ceil((double)totalItem/limit);

        if(totalPage==0) totalPage=1;
        if(page>totalPage) page=totalPage;

        int offset = (page - 1) * limit;

        List<ProductCategory> productcategorypage= productCategoryService.findAllPaging(offset,limit);
        ModelAndView mav = new ModelAndView("/admin/category/index");
        mav.addObject("listCategory", productcategorypage);   // <-- PHẢI dùng paging

        // Gửi thông tin phân trang về view
        mav.addObject("page", page);
        mav.addObject("limit", limit);
        mav.addObject("totalPage", totalPage);
        mav.addObject("totalItem", totalItem);
        return mav;
    }

    @RequestMapping(value = "/admin-category-add", method = RequestMethod.GET)
    public ModelAndView addPage() {
        ModelAndView mav = new ModelAndView("admin/category/add");
        mav.addObject("parentCategories", productCategoryService.findParentCategories());
        mav.addObject("category", new ProductCategory());
        return mav;
    }
    @RequestMapping(value = "/admin-category-add", method = RequestMethod.POST)
    public String saveCategory(@ModelAttribute("category") ProductCategory category,
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
            category.setImage("/uploads/" +fileName);
        }
        if (category.getParentId() == null || category.getParentId() == 0) {
            category.setParentId(null);
        }
        productCategoryService.insert(category);
        return "redirect:/admin-category"; // Quay lại trang danh sách
    }
    @RequestMapping(value = "admin-category-edit/{id}",method = RequestMethod.GET)
    public ModelAndView editCategory(@PathVariable("id") int id) {
        ProductCategory category= productCategoryService.findOne(id);
        ModelAndView mav = new ModelAndView("admin/category/edit");
        mav.addObject("parentCategory", productCategoryService.findParentCategories());
        mav.addObject("categoryEdit", category);
        return mav;
    }
    @RequestMapping(value = "admin-category-edit/{id}",method = RequestMethod.POST)
    public String updateCategory(@PathVariable ("id") int id ,@ModelAttribute("categoryEdit") ProductCategory category,
                                 @RequestParam("fileAnh") MultipartFile fileAnh,
                                 HttpServletRequest request) throws Exception {
        category.setId(id);
        if (!fileAnh.isEmpty()) {
            String uploadPath = request.getServletContext().getRealPath("/uploads");

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            String fileName = System.currentTimeMillis() + "_" + fileAnh.getOriginalFilename();
            File destFile = new File(uploadDir, fileName);
            fileAnh.transferTo(destFile);

            category.setImage("/uploads/"+fileName);
        }else {
            ProductCategory old= productCategoryService.findOne(id);
            category.setImage(old.getImage());
            }
        if (category.getParentId() == null || category.getParentId() == 0) {
            category.setParentId(null);
        }
        productCategoryService.update(category);
        return "redirect:/admin-category";
    }

    @RequestMapping(value = "admin-category-delete/{id}", method = RequestMethod.GET)
    public String deleteCategory(@PathVariable("id") int id) {
        productCategoryService.delete(id);
        return "redirect:/admin-category";
    }

}
