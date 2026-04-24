package khoaluantotnghiep.service.impl;

import khoaluantotnghiep.Dao.IBrandDao;
import khoaluantotnghiep.Dao.IProductCategory;
import khoaluantotnghiep.Dao.IProductDao;
import khoaluantotnghiep.Dao.ISeriesDao;
import khoaluantotnghiep.model.Brand;
import khoaluantotnghiep.model.Product;
import khoaluantotnghiep.model.ProductCategory;
import khoaluantotnghiep.model.Series;
import khoaluantotnghiep.service.IProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductService implements IProductService {
    @Autowired
    private IProductDao productDao;

    @Autowired
    private IProductCategory productCategoryDao;

    @Autowired
    private ISeriesDao seriesDao;

    @Autowired
    private IBrandDao brandDao;

    @Override
    public Product save(Product product) {
        return productDao.insert(product);
    }

    @Override
    public Product update(Product updateProduct) {
        return productDao.update(updateProduct);
    }

    @Override
    public void delete(int id) {
        productDao.delete(id);
    }

    @Override
    public Product findOne(int id) {
        return productDao.findOne(id);
    }

    @Override
    public Product findCategoryById(int id) {
        return productDao.findCategoryById(id);
    }

    @Override
    public List<Product> findAllPaging(int offset, int limit) {
        return productDao.findAllPaging(offset, limit);
    }

    @Override
    public int countAll() {
        return productDao.countAll();
    }

    @Override
    public List<Product> findAll() {
        return productDao.findAll();
    }



    @Override
    public void saveAll(List<Product> products) {
        List<ProductCategory> cats = productCategoryDao.findAll();
        List<Series> series = seriesDao.findAll();
        List<Brand> brands = brandDao.findAll();

        for (Product product : products) {
            // Resolve Category
            if (product.getCategoryName() != null && !product.getCategoryName().isEmpty()) {
                for (khoaluantotnghiep.model.ProductCategory cat : cats) {
                    if (cat.getName().equalsIgnoreCase(product.getCategoryName())) {
                        product.setCategoryId(cat.getId());
                        break;
                    }
                }
            }
            // Resolve Series
            if (product.getSeriesName() != null && !product.getSeriesName().isEmpty()) {
                for (khoaluantotnghiep.model.Series ser : series) {
                    if (ser.getName().equalsIgnoreCase(product.getSeriesName())) {
                        product.setSeriesId(ser.getId());
                        break;
                    }
                }
            }
            // Resolve Brand
            if (product.getBrandName() != null && !product.getBrandName().isEmpty()) {
                for (khoaluantotnghiep.model.Brand brand : brands) {
                    if (brand.getName().equalsIgnoreCase(product.getBrandName())) {
                        product.setBrandId(brand.getId());
                        break;
                    }
                }
            }
            productDao.insert(product);
        }
    }
}
