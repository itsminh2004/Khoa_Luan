package khoaluantotnghiep.service.impl;

import khoaluantotnghiep.Dao.IProductCommentDao;
import khoaluantotnghiep.model.ProductComment;
import khoaluantotnghiep.service.IProductCommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class ProductCommentService implements IProductCommentService {
    @Autowired
    private IProductCommentDao commentDao;

    @Override
    public ProductComment save(ProductComment comment) {
        return commentDao.insert(comment);
    }

    @Override
    public List<ProductComment> findByProductId(int productId) {
        return commentDao.findByProductId(productId);
    }

    @Override
    public List<ProductComment> findAll() {
        return commentDao.findAll();
    }

    @Override
    public void delete(int id) {
        commentDao.delete(id);
    }
}
