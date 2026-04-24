package khoaluantotnghiep.api.web;

import khoaluantotnghiep.dto.ProductCategoryDto;
import khoaluantotnghiep.dto.RootCategoryDto;
import khoaluantotnghiep.model.ProductCategory;
import khoaluantotnghiep.model.RootCategory;
import khoaluantotnghiep.service.IProductCategoryService;
import khoaluantotnghiep.service.IRootCategoryService;
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
    private IRootCategoryService rootCategoryService;

    @RequestMapping(value = "/categories", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
    @ResponseBody
    public List<RootCategoryDto> listCategories() {
        List<RootCategory> categories = rootCategoryService.findAll();
        List<RootCategoryDto> dtos = new ArrayList<>();
        if (categories != null) {
            for (RootCategory c : categories) {
                String img = c.getImage();
               RootCategoryDto dto = new RootCategoryDto(c.getId(), c.getName(), c.getDescription(), img,
                        c.getAlias());
                dtos.add(dto);
            }
        }
        return dtos;
    }
}
