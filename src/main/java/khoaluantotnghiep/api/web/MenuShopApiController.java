package khoaluantotnghiep.api.web;

import khoaluantotnghiep.model.ProductCategory;
import khoaluantotnghiep.model.Series;
import khoaluantotnghiep.service.IProductCategoryService;
import khoaluantotnghiep.service.ISeriesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/menu")
public class MenuShopApiController {
    @Autowired
    private IProductCategoryService productCategoryService;
    @Autowired
    private ISeriesService seriesService;

    @GetMapping("/categories")
    public Map<String, Object> getMenuData() {
        List<ProductCategory> allCategories = productCategoryService.findAll();

        // Lọc category cha (ParentId = null)
        List<ProductCategory> parentCategories = allCategories.stream()
                .filter(cat -> cat.getParentId() == null)
                .collect(Collectors.toList());

        // Tạo Map: CategoryId -> List<Series>
        Map<Integer, List<Series>> categorySeriesMap = new HashMap<>();
        for (ProductCategory category : allCategories) {
            List<Series> seriesList = seriesService.findByCategoryId(category.getId());
            if (seriesList != null && !seriesList.isEmpty()) {
                categorySeriesMap.put(category.getId(), seriesList);
            }
        }

        Map<String, Object> response = new HashMap<>();
        response.put("parentCategories", parentCategories);
        response.put("allCategories", allCategories);
        response.put("categorySeriesMap", categorySeriesMap);

        return response;
    }

    // Endpoint tree: trả về thêm children theo ParentId để tiện render menu nhiều cấp
    @GetMapping("/categories/tree")
    public Map<String, Object> getMenuTree() {
        List<ProductCategory> allCategories = productCategoryService.findAll();

        List<ProductCategory> parentCategories = allCategories.stream()
                .filter(cat -> cat.getParentId() == null)
                .collect(Collectors.toList());

        // Map ParentId -> List<ProductCategory> (con)
        Map<Integer, List<ProductCategory>> childrenByParentId = allCategories.stream()
                .filter(cat -> cat.getParentId() != null)
                .collect(Collectors.groupingBy(ProductCategory::getParentId));

        // Tạo Map: CategoryId -> List<Series>
        Map<Integer, List<Series>> categorySeriesMap = new HashMap<>();
        for (ProductCategory category : allCategories) {
            List<Series> seriesList = seriesService.findByCategoryId(category.getId());
            if (seriesList != null && !seriesList.isEmpty()) {
                categorySeriesMap.put(category.getId(), seriesList);
            }
        }

        Map<String, Object> response = new HashMap<>();
        response.put("parentCategories", parentCategories);
        response.put("childrenByParentId", childrenByParentId);
        response.put("categorySeriesMap", categorySeriesMap);
        return response;
    }

    // API lấy series theo categoryId
    @GetMapping("/series/{categoryId}")
    public List<Series> getSeriesByCategory(@PathVariable("categoryId") int categoryId) {
        return seriesService.findByCategoryId(categoryId);
    }

}
