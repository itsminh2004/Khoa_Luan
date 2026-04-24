package khoaluantotnghiep.controller.admin;

import khoaluantotnghiep.model.Product;
import khoaluantotnghiep.model.ProductImage;
import khoaluantotnghiep.model.ProductVariantNew;
import khoaluantotnghiep.model.StockEntry;
import khoaluantotnghiep.service.*;
import khoaluantotnghiep.service.impl.ProductColorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller(value = "stockControllerOfAdmin")
public class StockController {

    @Autowired
    private IStockEntryService stockEntryService;

    @Autowired
    private IProductService productService;

    @Autowired
    private IProductVariantNewService productVariantNewService;

    @Autowired
    private IProductColorService productColorService;

    @Autowired
    private IProductRamRomService productRamRomService;

    @Autowired
    private IProductImageService productImageService;
    @RequestMapping(value = "/admin-inventory", method = RequestMethod.GET)
    public ModelAndView inventory() {
        ModelAndView mav = new ModelAndView("/admin/stock/inventory");
        List<Product> products = productService.findAll();
        for(Product product : products){
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
            List<ProductVariantNew> variants = productVariantNewService.findByProductId(product.getId());
            for(ProductVariantNew v : variants){
                v.setColor(productColorService.findById(v.getColorId()));
                if(v.getRamRomId()!=null){
                    v.setRamRom(productRamRomService.findById(v.getRamRomId()));
                }
            }
            product.setVariants(variants);
        }
        mav.addObject("products", products);
        return mav;
    }
    @RequestMapping(value = "/admin-stock-list", method = RequestMethod.GET)
    public ModelAndView list() {
        ModelAndView mav = new ModelAndView("admin/stock/list");
        mav.addObject("stockEntries", stockEntryService.findAll());
        return mav;
    }

    @RequestMapping(value = "/admin-stock-entry", method = RequestMethod.GET)
    public ModelAndView stockEntry(
            @RequestParam(value = "productId", required = false) Integer productId) {
        ModelAndView mav = new ModelAndView("admin/stock/entry");
        mav.addObject("products", productService.findAll());

        if (productId != null && productId > 0) {
            mav.addObject("variants", productVariantNewService.findByProductId(productId));
            mav.addObject("selectedProductId", productId);
        }

        mav.addObject("stockEntry", new StockEntry());
        return mav;
    }

    @RequestMapping(value = "/admin-stock-entry", method = RequestMethod.POST)
    public String save(@org.springframework.web.bind.annotation.ModelAttribute("stockEntry") StockEntry entry) {
        stockEntryService.save(entry);
        return "redirect:/admin-stock-list";
    }
}