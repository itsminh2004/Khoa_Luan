package khoaluantotnghiep.api.web;

import khoaluantotnghiep.dto.BrandDto;
import khoaluantotnghiep.model.Brand;
import khoaluantotnghiep.service.IBrandService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@CrossOrigin(origins = "http://127.0.0.1:5500")
@Controller
@RequestMapping("/api")
public class BrandApiController {

    @Autowired
    private IBrandService brandService;

    @GetMapping(value = "/brands", produces = "application/json; charset=UTF-8")
    @ResponseBody
    public List<BrandDto> getAllBrands() {
        List<Brand> brands = brandService.findAll();
        if (brands == null) return Collections.emptyList();
        return brands.stream()
                .map(b -> new BrandDto(b.getId(), b.getName(), b.getAlias(), b.getLogo()))
                .collect(Collectors.toList());
    }

    @GetMapping(value = "/brands/{id}", produces = "application/json; charset=UTF-8")
    @ResponseBody
    public BrandDto getBrandById(@PathVariable("id") int id) {
        Brand b = brandService.findOne(id);
        if (b == null) return null;
        return new BrandDto(b.getId(), b.getName(), b.getAlias(), b.getLogo());
    }
}
