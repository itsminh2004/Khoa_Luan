package khoaluantotnghiep.service.impl;

import khoaluantotnghiep.Dao.IProductRamRomDao;
import khoaluantotnghiep.model.ProductRamRom;
import khoaluantotnghiep.service.IProductRamRomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductRamRomService implements IProductRamRomService {
    @Autowired
    private IProductRamRomDao productRamRomDao;

    @Override
    public ProductRamRom save(ProductRamRom ramRom) {
        return productRamRomDao.save(ramRom);
    }

    @Override
    public ProductRamRom update(ProductRamRom ramRom) {
        return productRamRomDao.update(ramRom);
    }

    @Override
    public void delete(int id) {
        productRamRomDao.delete(id);
    }

    @Override
    public List<ProductRamRom> findByProductId(int productId) {
        return productRamRomDao.findByProductId(productId);
    }

    @Override
    public ProductRamRom findById(int id) {
        return productRamRomDao.findById(id);
    }
}

