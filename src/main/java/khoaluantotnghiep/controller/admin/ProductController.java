package khoaluantotnghiep.controller.admin;

import khoaluantotnghiep.model.*;
import khoaluantotnghiep.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import khoaluantotnghiep.utils.ExcelHelper;
import org.springframework.core.io.InputStreamResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

@Controller
public class ProductController {

    @Autowired
    private IProductService productService;

    @Autowired
    private IProductCategoryService productCategoryService;

    @Autowired
    private IProductImageService productImageService;

    @Autowired
    private IProductColorService productColorService;

    @Autowired
    private IProductRamRomService productRamRomService;

    @Autowired
    private IProductVariantNewService productVariantNewService;

    @Autowired
    private IProductSpecificationService productSpecificationService;

    @Autowired
    private ISeriesService seriesService;

    @Autowired
    private IBrandService brandService;

    // 🟢 Danh sách sản phẩm
    @RequestMapping("/admin-product")
    public ModelAndView listProduct(@RequestParam(value = "page", defaultValue = "1") int page,
                                    @RequestParam(value = "limit", defaultValue = "10") int limit) {
        if (page < 1)
            page = 1;
        if (limit <= 0)
            limit = 10;

        int totalItem = productService.countAll();
        int totalPage = (int) Math.ceil((double) totalItem / limit);

        if (totalPage == 0)
            totalPage = 1;
        if (page > totalPage)
            page = totalPage;

        int offset = (page - 1) * limit;

        ModelAndView mav = new ModelAndView("admin/product/index");
        List<Product> products = productService.findAllPaging(offset, limit);

        // Lấy ảnh đại diện
        for (Product product : products) {
            if(product.getImage() == null || product.getImage().isEmpty()){
                List<ProductImage> imgs = productImageService.findByProductId(product.getId());
                if (imgs != null) {
                    for (ProductImage img : imgs) {
                        if(img.getColorId()==null){
                            product.setImage(img.getImageUrl());
                            break;
                        }
                    }
                }
            }
        }

        mav.addObject("products", products);
        mav.addObject("page", page);
        mav.addObject("limit", limit);
        mav.addObject("totalPage", totalPage);
        mav.addObject("totalItem", totalItem);
        return mav;
    }

    // 🟢 Thêm sản phẩm (GET)
    @RequestMapping(value = "/admin-product-add", method = RequestMethod.GET)
    public ModelAndView addProductForm() {
        ModelAndView mav = new ModelAndView("admin/product/add");
        mav.addObject("product", new Product());
        mav.addObject("productCategories", productCategoryService.findAll());
        mav.addObject("brands", brandService.findAll());
        return mav;
    }

    // 🟢 Thêm sản phẩm (POST) - hỗ trợ nhiều ảnh và variants
    @RequestMapping(value = "/admin-product-add", method = RequestMethod.POST)
    public String saveProduct(@ModelAttribute("product") Product product,
                              @RequestParam(value = "fileAnh", required = false) MultipartFile[] files,
                              @RequestParam(value = "hasVariants", defaultValue = "false") boolean hasVariants,
                              @RequestParam(value = "defaultRam", required = false) String defaultRam,
                              @RequestParam(value = "defaultRom", required = false) String defaultRom,
                              HttpServletRequest request) throws Exception {

        String uploadPath = request.getServletContext().getRealPath("/uploads");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists())
            uploadDir.mkdirs();

        // 1. Upload ảnh chính, lấy ảnh đầu tiên làm ảnh đại diện
        String mainImagePath = null;
        List<String> imagePaths = new java.util.ArrayList<>();

        if (files != null) {
            for (MultipartFile file : files) {
                if (file != null && !file.isEmpty()) {
                    String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
                    File destFile = new File(uploadDir, fileName);
                    file.transferTo(destFile);
                    String url = "/uploads/" + fileName;
                    imagePaths.add(url);
                    if (mainImagePath == null) {
                        mainImagePath = url;
                    }
                }
            }
        }

        // Nếu có ít nhất một ảnh, set ảnh đại diện
        if (mainImagePath != null) {
            product.setImage(mainImagePath);
        }

        // Set variant fields
        product.setHasVariants(hasVariants);
        product.setDefaultRam(defaultRam);
        product.setDefaultRom(defaultRom);

        // 2. Lưu sản phẩm
        productService.save(product);
        int productId = product.getId();

        // 3. Lưu tất cả ảnh chính vào bảng tb_ProductImage
        for (String url : imagePaths) {
            ProductImage img = new ProductImage();
            img.setProductId(productId);
            img.setImageUrl(url);
            productImageService.insert(img);
        }

        // 4. Nếu có variants, xử lý colors, RAM/ROM, variants và ảnh theo màu
        if (hasVariants) {
            // Xử lý màu sắc
            Map<Integer, Integer> colorIdMap = new java.util.HashMap<>();
            Map<String, String[]> colorParams = request.getParameterMap();

            for (String key : colorParams.keySet()) {
                if (key.startsWith("colors[") && key.contains("].colorName")) {
                    // Extract index: colors[1].colorName -> 1
                    String indexStr = key.substring(key.indexOf('[') + 1, key.indexOf(']'));
                    int index = Integer.parseInt(indexStr);

                    String colorName = request.getParameter("colors[" + index + "].colorName");
                    String colorCode = request.getParameter("colors[" + index + "].colorCode");

                    if (colorName != null && !colorName.trim().isEmpty()) {
                        ProductColor color = new ProductColor();
                        color.setProductId(productId);
                        color.setColorName(colorName.trim());
                        color.setColorCode(colorCode != null ? colorCode.trim() : null);
                        productColorService.save(color);
                        colorIdMap.put(index, color.getId());

                        // Upload ảnh cho màu này
                        if (request instanceof MultipartHttpServletRequest) {
                            MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
                            List<MultipartFile> colorImageFiles = multipartRequest
                                    .getFiles("colorImages[" + index + "]");

                            if (colorImageFiles != null && !colorImageFiles.isEmpty()) {
                                for (MultipartFile colorFile : colorImageFiles) {
                                    if (colorFile != null && !colorFile.isEmpty()) {
                                        String fileName = System.currentTimeMillis() + "_"
                                                + colorFile.getOriginalFilename();
                                        File destFile = new File(uploadDir, fileName);
                                        colorFile.transferTo(destFile);
                                        String url = "/uploads/" + fileName;

                                        ProductImage img = new ProductImage();
                                        img.setProductId(productId);
                                        img.setColorId(color.getId());
                                        img.setImageUrl(url);
                                        productImageService.insert(img);

                                        // Nếu chưa có ảnh đại diện, dùng ảnh đầu tiên của màu đầu tiên
                                        if (mainImagePath == null) {
                                            mainImagePath = url;
                                            product.setImage(url);
                                            productService.update(product);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            // Xử lý RAM/ROM
            Map<Integer, Integer> ramRomIdMap = new java.util.HashMap<>();

            for (String key : colorParams.keySet()) {
                if (key.startsWith("ramRoms[") && key.contains("].ram")) {
                    String indexStr = key.substring(key.indexOf('[') + 1, key.indexOf(']'));
                    int index = Integer.parseInt(indexStr);

                    String ram = request.getParameter("ramRoms[" + index + "].ram");
                    String rom = request.getParameter("ramRoms[" + index + "].rom");

                    if (ram != null && !ram.trim().isEmpty() && rom != null && !rom.trim().isEmpty()) {
                        ProductRamRom ramRom = new ProductRamRom();
                        ramRom.setProductId(productId);
                        ramRom.setRam(ram.trim());
                        ramRom.setRom(rom.trim());
                        productRamRomService.save(ramRom);
                        ramRomIdMap.put(index, ramRom.getId());
                    }
                }
            }

            // Xử lý variants (tự động tạo từ màu × RAM/ROM)
            for (String key : colorParams.keySet()) {
                if (key.startsWith("variants[") && key.contains("].colorId")) {
                    // Extract variant key: variants[v-1-2].colorId -> v-1-2
                    String variantKey = key.substring(key.indexOf('[') + 1, key.indexOf(']'));

                    String colorIdStr = request.getParameter("variants[" + variantKey + "].colorId");
                    String ramRomIdStr = request.getParameter("variants[" + variantKey + "].ramRomId");
                    String priceStr = request.getParameter("variants[" + variantKey + "].price");
                    String priceSaleStr = request.getParameter("variants[" + variantKey + "].priceSale");
                    String stockStr = request.getParameter("variants[" + variantKey + "].stock");

                    if (colorIdStr != null && ramRomIdStr != null && priceStr != null) {
                        try {
                            int colorIndex = Integer.parseInt(colorIdStr);
                            int ramRomIndex = Integer.parseInt(ramRomIdStr);

                            Integer actualColorId = colorIdMap.get(colorIndex);
                            Integer actualRamRomId = ramRomIdMap.get(ramRomIndex);

                            if (actualColorId != null && actualRamRomId != null) {
                                ProductVariantNew variant = new ProductVariantNew();
                                variant.setProductId(productId);
                                variant.setColorId(actualColorId);
                                variant.setRamRomId(actualRamRomId);
                                variant.setPrice(new BigDecimal(priceStr));
                                if (priceSaleStr != null && !priceSaleStr.trim().isEmpty()) {
                                    variant.setPriceSale(new BigDecimal(priceSaleStr));
                                }
                                variant.setStock(stockStr != null ? Integer.parseInt(stockStr) : 0);
                                productVariantNewService.save(variant);
                            }
                        } catch (NumberFormatException e) {
                            // Skip invalid variant
                        }
                    }
                }
            }
        }

        // 5. Xử lý thông số kỹ thuật
        Map<String, String[]> allParams = request.getParameterMap();
        for (String key : allParams.keySet()) {
            if (key.startsWith("specs[") && key.contains("].key")) {
                String indexStr = key.substring(key.indexOf('[') + 1, key.indexOf(']'));
                int index = Integer.parseInt(indexStr);

                String specKey = request.getParameter("specs[" + index + "].key");
                String specValue = request.getParameter("specs[" + index + "].value");

                if (specKey != null && !specKey.trim().isEmpty() && specValue != null && !specValue.trim().isEmpty()) {
                    ProductSpecification spec = new ProductSpecification();
                    spec.setProductId(productId);
                    spec.setKey(specKey.trim());
                    spec.setValue(specValue.trim());
                    productSpecificationService.save(spec);
                }
            }
        }

        return "redirect:/admin-product";
    }

    @RequestMapping(value = "/admin-product-edit/{id}", method = RequestMethod.GET)
    public ModelAndView editProduct(@PathVariable("id") int id) {
        Product product = productService.findOne(id);
        List<ProductCategory> categories = productCategoryService.findAll();
        List<ProductImage> images = productImageService.findByProductId(id);
        List<Series> seriesList = new java.util.ArrayList<>();
        if (product.getCategoryId() > 0) {
            seriesList = seriesService.findByCategoryId(product.getCategoryId());
        }

        ModelAndView mav = new ModelAndView("admin/product/edit");
        mav.addObject("product", product);
        mav.addObject("productCategories", categories);
        mav.addObject("productImages", images);
        mav.addObject("seriesList", seriesList);
        mav.addObject("brands", brandService.findAll());
        mav.addObject("selectedCategoryId", product.getCategoryId());
        return mav;
    }

    @RequestMapping(value = "/admin-product-edit/{id}", method = RequestMethod.POST)
    public String updateProduct(@PathVariable("id") int id,
                                @ModelAttribute("product") Product product,
                                @RequestParam(value = "fileAnh", required = false) MultipartFile[] files,
                                @RequestParam(value = "selectedImageId", required = false) Integer selectedImageId,
                                @RequestParam(value = "hasVariants", defaultValue = "false") boolean hasVariants,
                                @RequestParam(value = "defaultRam", required = false) String defaultRam,
                                @RequestParam(value = "defaultRom", required = false) String defaultRom,
                                HttpServletRequest request) throws Exception {
        product.setId(id);
        String uploadPath = request.getServletContext().getRealPath("/uploads");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists())
            uploadDir.mkdirs();

        // Lấy sản phẩm cũ để giữ lại ảnh nếu cần
        Product old = productService.findOne(id);

        // 1. Nếu chọn ảnh đại diện từ ảnh phụ cũ
        if (selectedImageId != null) {
            ProductImage mainImg = productImageService.findOne(selectedImageId);
            if (mainImg != null && mainImg.getImageUrl() != null) {
                product.setImage(mainImg.getImageUrl());
            }
        }

        // 2. Upload thêm ảnh mới (nếu có)
        if (files != null) {
            for (MultipartFile file : files) {
                if (file != null && !file.isEmpty()) {
                    String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
                    File destFile = new File(uploadDir, fileName);
                    file.transferTo(destFile);
                    String url = "/uploads/" + fileName;

                    // Nếu hiện chưa có ảnh đại diện (cũ hoặc do selectedImageId), dùng ảnh mới đầu
                    // tiên
                    if (product.getImage() == null || product.getImage().isEmpty()) {
                        product.setImage(url);
                    }

                    ProductImage img = new ProductImage();
                    img.setProductId(id);
                    img.setImageUrl(url);
                    productImageService.insert(img);
                }
            }
        }

        // 3. Nếu vẫn chưa có ảnh nào được set → giữ ảnh cũ
        if (product.getImage() == null || product.getImage().isEmpty()) {
            if (old != null) {
                product.setImage(old.getImage());
            }
        }

        // Set variant fields
        product.setHasVariants(hasVariants);
        product.setDefaultRam(defaultRam);
        product.setDefaultRom(defaultRom);

        productService.update(product);
        return "redirect:/admin-product";
    }

    @RequestMapping(value = "/admin-product-detail/{id}", method = RequestMethod.GET)
    public ModelAndView detail(@PathVariable("id") int id) {
        Product product = productService.findOne(id);
        List<ProductImage> images = productImageService.findByProductId(id);
        if (images != null) {
            product.setImages(images);
        }

        // Load new variant structure
        List<ProductColor> colors = productColorService.findByProductId(id);
        List<ProductRamRom> ramRoms = productRamRomService.findByProductId(id);
        List<ProductVariantNew> variantsNew = productVariantNewService.findByProductId(id);

        // Load related data for variants
        for (ProductVariantNew v : variantsNew) {
            v.setColor(productColorService.findById(v.getColorId()));
            if (v.getRamRomId() != null) {
                v.setRamRom(productRamRomService.findById(v.getRamRomId()));
            }
            // Load images for this variant (by color_id)
            List<ProductImage> variantImages = new java.util.ArrayList<>();
            for (ProductImage img : images) {
                if (img.getColorId() != null && img.getColorId() == v.getColorId()) {
                    variantImages.add(img);
                }
            }
        }

        ModelAndView mav = new ModelAndView("admin/product/detail");
        mav.addObject("product", product);
        mav.addObject("colors", colors);
        mav.addObject("ramRoms", ramRoms);
        mav.addObject("variantsNew", variantsNew);
        mav.addObject("specs", productSpecificationService.findByProductId(id));
        return mav;
    }

    // 🟢 Thêm màu cho sản phẩm
    @RequestMapping(value = "/admin-product/{id}/color", method = RequestMethod.POST)
    public String addColor(@PathVariable("id") int productId,
                           @RequestParam("colorName") String colorName,
                           @RequestParam(value = "colorCode", required = false) String colorCode) {
        ProductColor color = new ProductColor();
        color.setProductId(productId);
        color.setColorName(colorName);
        color.setColorCode(colorCode);
        productColorService.save(color);
        return "redirect:/admin-product-detail/" + productId;
    }

    // 🟢 Xóa màu
    @RequestMapping(value = "/admin-product/{productId}/color/{colorId}/delete", method = RequestMethod.GET)
    public String deleteColor(@PathVariable("productId") int productId,
                              @PathVariable("colorId") int colorId) {
        // Xóa tất cả variants liên quan đến màu này trước
        productVariantNewService.deleteByColorId(colorId);
        // Xóa tất cả ảnh liên quan đến màu này
        productImageService.deleteByColorId(colorId);
        // Sau đó mới xóa màu
        productColorService.delete(colorId);
        return "redirect:/admin-product-detail/" + productId;
    }

    // 🟢 Thêm RAM/ROM cho sản phẩm
    @RequestMapping(value = "/admin-product/{id}/ramrom", method = RequestMethod.POST)
    public String addRamRom(@PathVariable("id") int productId,
                            @RequestParam("ram") String ram,
                            @RequestParam("rom") String rom) {
        ProductRamRom ramRom = new ProductRamRom();
        ramRom.setProductId(productId);
        ramRom.setRam(ram);
        ramRom.setRom(rom);
        productRamRomService.save(ramRom);
        return "redirect:/admin-product-detail/" + productId;
    }

    // 🟢 Xóa RAM/ROM
    @RequestMapping(value = "/admin-product/{productId}/ramrom/{ramRomId}/delete", method = RequestMethod.GET)
    public String deleteRamRom(@PathVariable("productId") int productId,
                               @PathVariable("ramRomId") int ramRomId) {
        productRamRomService.delete(ramRomId);
        return "redirect:/admin-product-detail/" + productId;
    }

    // 🟢 Thêm variant mới cho sản phẩm
    @RequestMapping(value = "/admin-product/{id}/variant-new", method = RequestMethod.POST)
    public String addVariantNew(@PathVariable("id") int productId,
                                @RequestParam("colorId") int colorId,
                                @RequestParam(value = "ramRomId", required = false) Integer ramRomId,
                                @RequestParam("price") BigDecimal price,
                                @RequestParam(value = "priceSale", required = false) BigDecimal priceSale,
                                @RequestParam("stock") int stock) {
        ProductVariantNew variant = new ProductVariantNew();
        variant.setProductId(productId);
        variant.setColorId(colorId);
        variant.setRamRomId(ramRomId);
        variant.setPrice(price);
        variant.setPriceSale(priceSale);
        variant.setStock(stock);
        productVariantNewService.save(variant);
        return "redirect:/admin-product-detail/" + productId;
    }

    // 🟢 Xóa variant mới
    @RequestMapping(value = "/admin-product/{productId}/variant-new/{variantId}/delete", method = RequestMethod.GET)
    public String deleteVariantNew(@PathVariable("productId") int productId,
                                   @PathVariable("variantId") int variantId) {
        productVariantNewService.delete(variantId);
        return "redirect:/admin-product-detail/" + productId;
    }

    // 🟢 Upload ảnh cho màu
    @RequestMapping(value = "/admin-product/{productId}/color/{colorId}/images", method = RequestMethod.POST)
    public String uploadColorImages(@PathVariable("productId") int productId,
                                    @PathVariable("colorId") int colorId,
                                    @RequestParam("colorImages") MultipartFile[] files,
                                    HttpServletRequest request) throws Exception {

        String uploadPath = request.getServletContext().getRealPath("/uploads");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists())
            uploadDir.mkdirs();

        if (files != null) {
            for (MultipartFile file : files) {
                if (file != null && !file.isEmpty()) {
                    String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
                    File destFile = new File(uploadDir, fileName);
                    file.transferTo(destFile);
                    String url = "/uploads/" + fileName;

                    ProductImage img = new ProductImage();
                    img.setProductId(productId);
                    img.setColorId(colorId);
                    img.setImageUrl(url);
                    productImageService.insert(img);
                }
            }
        }
        return "redirect:/admin-product-detail/" + productId;
    }

    // 🟢 Thêm specification cho sản phẩm (từng cái một - giữ lại để tương thích)
    @RequestMapping(value = "/admin-product/{id}/specification", method = RequestMethod.POST)
    public String addSpecification(@PathVariable("id") int productId,
                                   @RequestParam("specKey") String specKey,
                                   @RequestParam("specValue") String specValue) {
        ProductSpecification specification = new ProductSpecification();
        specification.setProductId(productId);
        specification.setKey(specKey);
        specification.setValue(specValue);
        productSpecificationService.save(specification);
        return "redirect:/admin-product-detail/" + productId;
    }

    // 🟢 Thêm nhiều specifications cùng lúc
    @RequestMapping(value = "/admin-product/{id}/specifications", method = RequestMethod.POST)
    public String addSpecificationsOneRow(
            @PathVariable("id") int productId,
            HttpServletRequest request) {

        java.util.Enumeration<String> paramNames = request.getParameterNames();
        while (paramNames.hasMoreElements()) {
            String key = paramNames.nextElement();
            String value = request.getParameter(key);

            // Bỏ qua các tham số hệ thống và ô trống
            if (key != null && !key.startsWith("_") && !key.equals("id") && value != null && !value.trim().isEmpty()) {
                ProductSpecification spec = new ProductSpecification();
                spec.setProductId(productId);
                spec.setKey(key);
                spec.setValue(value.trim());
                productSpecificationService.save(spec);
            }
        }
        return "redirect:/admin-product-detail/" + productId;
    }

    // 🟢 Xóa specification
    @RequestMapping(value = "/admin-product/{productId}/specification/{specId}/delete", method = RequestMethod.GET)
    public String deleteSpecification(@PathVariable("productId") int productId,
                                      @PathVariable("specId") int specId) {
        productSpecificationService.delete(specId);
        return "redirect:/admin-product-detail/" + productId;
    }

    @RequestMapping(value = "/admin-product/delete/{id}", method = RequestMethod.GET)
    public String deleteProduct(@PathVariable("id") int id) {
        productService.delete(id);
        return "redirect:/admin-product";
    }

    // 🟢 Nhập từ Excel
    @RequestMapping(value = "/admin-product-import", method = RequestMethod.POST)
    public String importExcel(@RequestParam("fileExcel") MultipartFile file) {
        if (ExcelHelper.hasExcelFormat(file)) {
            try {
                List<Product> products = ExcelHelper.excelToProducts(file.getInputStream());
                productService.saveAll(products);
                return "redirect:/admin-product?importSuccess=true";
            } catch (Exception e) {
                return "redirect:/admin-product?importError=" + e.getMessage();
            }
        }
        return "redirect:/admin-product?importError=InvalidFormat";
    }

    // 🟢 Xuất ra Excel
    @RequestMapping(value = "/admin-product-export", method = RequestMethod.GET)
    public ResponseEntity<Resource> exportExcel() {
        String filename = "products_" + System.currentTimeMillis() + ".xlsx";
        InputStreamResource file = new InputStreamResource(ExcelHelper.productsToExcel(productService.findAll()));

        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=" + filename)
                .contentType(MediaType.parseMediaType(ExcelHelper.TYPE))
                .body(file);
    }
}
