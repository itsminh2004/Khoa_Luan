package khoaluantotnghiep.api.admin;

import khoaluantotnghiep.model.*;
import khoaluantotnghiep.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/admin")
@Transactional
public class AdminApiController {
    @Autowired private IProductVariantNewService productVariantNewService;
    @Autowired private IProductColorService productColorService;
    @Autowired private IProductRamRomService productRamRomService;
    @Autowired private IProductSpecificationService productSpecificationService;


    @RequestMapping(value = "/product/{id}/variant-new", method = RequestMethod.POST, produces = "application/json; charset=UTF-8")
    @ResponseBody
    public ProductVariantNew saveVariantNew(@PathVariable("id") int productId, @RequestBody ProductVariantNew variant) {
        if (variant == null) {
            throw new IllegalArgumentException("Variant data is required");
        }
        if (variant.getColorId() <= 0) {
            throw new IllegalArgumentException("Color is required");
        }
        if (variant.getPrice() == null || variant.getPrice().compareTo(java.math.BigDecimal.ZERO) < 0) {
            throw new IllegalArgumentException("Price must be greater than or equal to 0");
        }
        if (variant.getStock() < 0) {
            throw new IllegalArgumentException("Stock must be greater than or equal to 0");
        }

        variant.setProductId(productId);
        ProductVariantNew saved = productVariantNewService.save(variant);

        ProductColor color = productColorService.findById(saved.getColorId());
        if (color != null) {
            saved.setColor(color);
        }
        if (saved.getRamRomId() != null) {
            ProductRamRom ramRom = productRamRomService.findById(saved.getRamRomId());
            if (ramRom != null) {
                saved.setRamRom(ramRom);
            }
        }
        return saved;
    }

    @RequestMapping(value = "/product/{id}/color", method = RequestMethod.POST, produces = "application/json; charset=UTF-8")
    @ResponseBody
    public ProductColor saveColor(@PathVariable("id") int productId, @RequestBody ProductColor color) {
        if (color == null) {
            throw new IllegalArgumentException("Color data is required");
        }
        if (color.getColorName() == null || color.getColorName().trim().isEmpty()) {
            throw new IllegalArgumentException("Color name is required");
        }
        color.setProductId(productId);
        return productColorService.save(color);
    }

    @RequestMapping(value = "/product/{id}/ramrom", method = RequestMethod.POST, produces = "application/json; charset=UTF-8")
    @ResponseBody
    public ProductRamRom saveRamRom(@PathVariable("id") int productId, @RequestBody ProductRamRom ramRom) {
        if (ramRom == null) {
            throw new IllegalArgumentException("RAM/ROM data is required");
        }
        if (ramRom.getRam() == null || ramRom.getRam().trim().isEmpty()) {
            throw new IllegalArgumentException("RAM is required");
        }
        if (ramRom.getRom() == null || ramRom.getRom().trim().isEmpty()) {
            throw new IllegalArgumentException("ROM is required");
        }
        ramRom.setProductId(productId);
        return productRamRomService.save(ramRom);
    }

    @RequestMapping(value = "/product/{id}/specification", method = RequestMethod.POST, produces = "application/json; charset=UTF-8")
    @ResponseBody
    public ProductSpecification saveSpecification(@PathVariable("id") int productId, @RequestBody ProductSpecification spec) {
        if (spec == null) {
            throw new IllegalArgumentException("Specification data is required");
        }

        // Chấp nhận cả attrKey/attrValue và key/value từ JSON
        if ((spec.getAttrKey() == null || spec.getAttrKey().trim().isEmpty()) && spec.getKey() != null) {
            spec.setAttrKey(spec.getKey());
        }
        if ((spec.getAttrValue() == null || spec.getAttrValue().trim().isEmpty()) && spec.getValue() != null) {
            spec.setAttrValue(spec.getValue());
        }

        if (spec.getAttrKey() == null || spec.getAttrKey().trim().isEmpty()) {
            throw new IllegalArgumentException("Specification key is required");
        }
        if (spec.getAttrValue() == null || spec.getAttrValue().trim().isEmpty()) {
            throw new IllegalArgumentException("Specification value is required");
        }

        spec.setProductId(productId);
        return productSpecificationService.save(spec);
    }
}
