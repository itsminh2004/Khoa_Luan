package khoaluantotnghiep.api.web;

import khoaluantotnghiep.dto.ProductDto;
import khoaluantotnghiep.dto.ProductSpecificationDto;
import khoaluantotnghiep.dto.ProductVariantDto;
import khoaluantotnghiep.model.*;
import khoaluantotnghiep.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@CrossOrigin(origins = "http://127.0.0.1:5500")
@Controller
@RequestMapping("/api")
public class ProductApiController {

    @Autowired
    private IProductService productService;

    @Autowired
    private IProductImageService productImageService;

    @Autowired
    private IProductCategoryService productCategoryService;

    @Autowired
    private IProductVariantNewService productVariantNewService; // cấu trúc mới (colorId, ramRomId)

    @Autowired
    private IProductColorService productColorService;

    @Autowired
    private IProductRamRomService productRamRomService;

    @Autowired
    private IProductSpecificationService productSpecificationService;

    @Autowired
    private IRootCategoryService rootCategoryService;

    // Lấy toàn bộ sản phẩm
    @RequestMapping(value = "/products", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
    @ResponseBody
    public List<ProductDto> listProducts() {
        List<Product> products = productService.findAll();
        return products.stream().map(this::convertToDto).collect(Collectors.toList());
    }
    @GetMapping(value = "/products/search", produces = "application/json; charset=UTF-8")
    @ResponseBody
    public List<ProductDto> searchProductsByName(@RequestParam(name = "q", required = false) String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return Collections.emptyList();
        }
        final String q = keyword.trim().toLowerCase();

        List<Product> products = productService.findAll();

        return products.stream()
                .filter(p -> p.getName() != null && p.getName().toLowerCase().contains(q))
                .limit(20) // giới hạn số kết quả trả về cho search
                .map(this::convertToDto)
                .collect(Collectors.toList());
    }

    // Lấy sản phẩm theo tên danh mục (ví dụ: "Điện thoại")
    @GetMapping(value = "/products/by-category", produces = "application/json; charset=UTF-8")
    @ResponseBody
    public List<ProductDto> listProductsByCategory(@RequestParam("name") String categoryName) {
        List<Product> products = productService.findAll();
        if (categoryName == null)
            categoryName = "";
        final String q = categoryName.trim().toLowerCase();

        return products.stream()
                .filter(p -> p.getCategoryName() != null && p.getCategoryName().toLowerCase().contains(q))
                .map(this::convertToDto)
                .collect(Collectors.toList());
    }

    // Lấy sản phẩm theo danh mục cha (theo TÊN)
    @GetMapping(value = "/products/by-parent-category", produces = "application/json; charset=UTF-8")
    @ResponseBody
    public List<ProductDto> listProductsByParentCategoryName(@RequestParam("name") String parentName) {
        if (parentName == null || parentName.trim().isEmpty())
            return Collections.emptyList();
        String q = parentName.trim().toLowerCase();

        List<ProductCategory> allCats = productCategoryService.findAll();
        if (allCats == null || allCats.isEmpty())
            return Collections.emptyList();

        List<RootCategory> rootCats = rootCategoryService.findAll();
        // Tìm danh mục cha theo tên
        RootCategory parent = rootCats.stream()
                .filter(c -> c.getName() != null && c.getName().toLowerCase().contains(q))
                .findFirst()
                .orElse(null);
        if (parent == null)
            return Collections.emptyList();

        int rootId = parent.getId();

        // Lấy id các danh mục con
        List<Integer> childCatIds = allCats.stream()
                .filter(c -> c.getRootCategoryId() != null && c.getRootCategoryId() == rootId)
                .map(ProductCategory::getId)
                .collect(Collectors.toList());

        // Lọc sản phẩm theo categoryId thuộc danh mục con
        List<Product> products = productService.findAll();
        return products.stream()
                .filter(p -> p != null && childCatIds.contains(p.getCategoryId()))
                .map(this::convertToDto)
                .collect(Collectors.toList());
    }

    // Lấy sản phẩm theo danh mục cha (theo ID)
    @GetMapping(value = "/products/by-parent-category-id/{rootId}", produces = "application/json; charset=UTF-8")
    @ResponseBody
    public List<ProductDto> listProductsByParentCategoryId(@PathVariable("rootId") int rootId) {
        List<ProductCategory> allCats = productCategoryService.findAll();
        if (allCats == null || allCats.isEmpty())
            return Collections.emptyList();

        List<Integer> childCatIds = allCats.stream()
                .filter(c -> c.getRootCategoryId() != null && c.getRootCategoryId() == rootId)
                .map(ProductCategory::getId)
                .collect(Collectors.toList());

        List<Product> products = productService.findAll();
        return products.stream()
                .filter(p -> p != null && childCatIds.contains(p.getCategoryId()))
                .map(this::convertToDto)
                .collect(Collectors.toList());
    }

    // Lấy sản phẩm theo seriesId
    @GetMapping(value = "/products/by-series/{seriesId}", produces = "application/json; charset=UTF-8")
    @ResponseBody
    public List<ProductDto> listProductsBySeries(@PathVariable("seriesId") int seriesId) {
        List<Product> products = productService.findAll();
        return products.stream()
                .filter(p -> p.getSeriesId() == seriesId)
                .map(this::convertToDto)
                .collect(Collectors.toList());
    }
    @GetMapping(value = "/products/by-brand", produces = "application/json; charset=UTF-8")
    @ResponseBody
    public List<ProductDto> listProductsByBrand(@RequestParam("name") String brandName) {

        if (brandName == null || brandName.trim().isEmpty())
            return Collections.emptyList();

        String q = brandName.trim().toLowerCase();

        List<Product> products = productService.findAll();

        return products.stream()
                .filter(p -> p.getBrandName() != null &&
                        p.getBrandName().toLowerCase().contains(q))
                .map(this::convertToDto)
                .collect(Collectors.toList());
    }

    // Lấy chi tiết sản phẩm theo id
    @RequestMapping(value = "/products/{id}", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
    @ResponseBody
    public ProductDto getProductDetail(@PathVariable("id") int id) {
        Product p = productService.findOne(id);
        if (p == null)
            return null;

        List<ProductImage> imgs = productImageService.findByProductId(id);
        String mainImage = null;
        if (imgs != null && !imgs.isEmpty()) {
            mainImage = imgs.get(0).getImageUrl();
        } else if (p.getImage() != null) {
            mainImage = p.getImage();
        }

        ProductDto dto = new ProductDto(
                p.getId(),
                p.getName(),
                p.getDescription(),
                p.getPrice(),
                p.getPriceSale(),
                p.getStock(),
                mainImage,
                p.getCategoryName(),
                p.getAlias(),
                p.isActive());
        attachVariantsAndSpecs(dto, p);
        return dto;
    }

    // Chuyển Product -> ProductDto
    private ProductDto convertToDto(Product p) {
        List<ProductImage> imgs = productImageService.findByProductId(p.getId());
        String mainImage = null;
        if (imgs != null && !imgs.isEmpty()) {
            mainImage = imgs.get(0).getImageUrl();
        } else if (p.getImage() != null) {
            mainImage = p.getImage();
        }

        ProductDto dto = new ProductDto(
                p.getId(),
                p.getName(),
                p.getDescription(),
                p.getPrice(),
                p.getPriceSale(),
                p.getStock(),
                mainImage,
                p.getCategoryName(),
                p.getAlias(),
                p.isActive());

        // Gắn thêm series (nếu có)
        dto.setSeriesId(p.getSeriesId() == 0 ? null : p.getSeriesId());
        dto.setSeriesName(p.getSeriesName());

        // Gắn thêm brand (nếu có)
        dto.setBrandId(p.getBrandId());
        dto.setBrandName(p.getBrandName());
        dto.setBrandLogo(p.getBrandLogo());

        // Gắn thêm variants/specs để hỗ trợ lọc ở frontend (RAM, ROM, etc.)
        attachVariantsAndSpecs(dto, p);

        return dto;
    }

    private void attachVariantsAndSpecs(ProductDto dto, Product p) {
        // ===== Variants (CHỈ dùng cấu trúc mới ProductVariantNew + ProductColor +
        // ProductRamRom) =====
        List<ProductVariantDto> variantDtos = new java.util.ArrayList<>();

        // Không phụ thuộc cờ hasVariants nữa, cứ lấy variantsNew trong DB
        List<ProductVariantNew> variantsNew = productVariantNewService.findByProductId(p.getId());
        List<ProductImage> productImages = productImageService.findByProductId(p.getId());

        if (variantsNew != null && !variantsNew.isEmpty()) {
            for (ProductVariantNew v : variantsNew) {
                ProductColor color = productColorService.findById(v.getColorId());
                ProductVariantDto vd = new ProductVariantDto();
                vd.setId(v.getId());
                vd.setColor(color != null ? color.getColorName() : "N/A");

                ProductRamRom ramRom = null;
                if (v.getRamRomId() != null) {
                    ramRom = productRamRomService.findById(v.getRamRomId());
                    if (ramRom != null) {
                        vd.setConfiguration(ramRom.getRam() + " / " + ramRom.getRom());
                    } else {
                        vd.setConfiguration("N/A");
                    }
                } else {
                    vd.setConfiguration("N/A");
                }

                vd.setPrice(v.getPrice());
                vd.setPriceSale(v.getPriceSale());
                vd.setStock(v.getStock());
                vd.setSku(null); // không dùng SKU cho cấu trúc mới

                // Ảnh theo màu (colorId)
                List<String> imgUrls = new java.util.ArrayList<>();
                if (productImages != null && color != null) {
                    for (ProductImage img : productImages) {
                        if (img.getColorId() != null && img.getColorId() == color.getId()
                                && img.getImageUrl() != null) {
                            imgUrls.add(img.getImageUrl());
                        }
                    }
                }
                // Fallback: nếu chưa có ảnh riêng cho màu → dùng ảnh chính
                if (imgUrls.isEmpty() && p.getImage() != null) {
                    imgUrls.add(p.getImage());
                }
                vd.setImages(imgUrls);
                variantDtos.add(vd);
            }
        }

        if (!variantDtos.isEmpty()) {
            dto.setVariants(variantDtos);
        }

        // ===== Specifications =====
        List<ProductSpecification> specs = productSpecificationService.findByProductId(p.getId());
        if (specs != null && !specs.isEmpty()) {
            List<ProductSpecificationDto> specDtos = new java.util.ArrayList<>();
            for (ProductSpecification s : specs) {
                ProductSpecificationDto sd = new ProductSpecificationDto();
                sd.setAttrKey(s.getAttrKey());
                sd.setAttrValue(s.getAttrValue());
                specDtos.add(sd);
            }
            dto.setSpecs(specDtos);
        }
    }
}
