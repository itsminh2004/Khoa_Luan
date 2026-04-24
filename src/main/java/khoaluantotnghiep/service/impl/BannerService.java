package khoaluantotnghiep.service.impl;

import khoaluantotnghiep.Dao.IBannerDao;
import khoaluantotnghiep.model.Banner;
import khoaluantotnghiep.service.IBannerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BannerService implements IBannerService {
    @Autowired
    private IBannerDao BannerDao;
    @Override
    public Banner save(Banner banner) {
        return BannerDao.save(banner);
    }

    @Override
    public Banner update(Banner banner) {
        return BannerDao.update(banner);
    }

    @Override
    public void delete(int id) {
        BannerDao.delete(id);
    }

    @Override
    public Banner findOne(int id) {
        return BannerDao.findOne(id);
    }

    @Override
    public List<Banner> findAllWithProduct(String position, Boolean active) {
        return BannerDao.findAllWithProduct(position, active);
    }

    @Override
    public List<Banner> findActive(String position) {
        return BannerDao.findActive(position);
    }

    @Override
    public boolean toggleActive(int id) {
        return BannerDao.toggleActive(id);
    }
}
