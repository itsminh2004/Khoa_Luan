package khoaluantotnghiep.Dao;

import khoaluantotnghiep.model.Product;

import java.util.List;

public interface IProductDao {
   Product insert(Product product);
   Product update(Product updateProduct);
   void   delete(int id);
   List<Product> findAll();
   Product findOne(int id);
   Product findCategoryById(int categoryId);
   List<Product> findAllPaging(int offset, int limit);
   int countAll();
}
