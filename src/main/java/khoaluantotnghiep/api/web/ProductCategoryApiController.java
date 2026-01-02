package khoaluantotnghiep.api.web;

import khoaluantotnghiep.dto.ProductCategoryDto;
import khoaluantotnghiep.model.ProductCategory;
import khoaluantotnghiep.service.IProductCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/api")
public class ProductCategoryApiController {
    @Autowired
    private IProductCategoryService categoryService;

    @RequestMapping(value = "/categories", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
    @ResponseBody
    public List<ProductCategoryDto> listCategories() {
        List<ProductCategory> categories = categoryService.findAll();
        List<ProductCategoryDto> dtos = new ArrayList<>();
        if (categories != null) {
            for (ProductCategory c : categories) {
                String img = c.getImage();
                ProductCategoryDto dto = new ProductCategoryDto(c.getId(), c.getName(), c.getDescription(), img, c.getAlias(), c.getParentId());
                dtos.add(dto);
            }
        }
        return dtos;
    }
}
