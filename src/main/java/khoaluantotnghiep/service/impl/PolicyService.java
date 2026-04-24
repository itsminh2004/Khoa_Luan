package khoaluantotnghiep.service.impl;

import khoaluantotnghiep.Dao.IPolicyDao;
import khoaluantotnghiep.model.Policy;
import khoaluantotnghiep.service.IPolicyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class PolicyService implements IPolicyService {
    @Autowired
    private IPolicyDao policyDao;

    @Override
    public Policy save(Policy policy) {
        if (policy.getId() > 0) {
            return policyDao.update(policy);
        } else {
            return policyDao.insert(policy);
        }
    }

    @Override
    public void delete(int id) {
        policyDao.delete(id);
    }

    @Override
    public List<Policy> findAll() {
        return policyDao.findAll();
    }

    @Override
    public Policy findOne(int id) {
        return policyDao.findOne(id);
    }

    @Override
    public Policy findBySlug(String slug) {
        return policyDao.findBySlug(slug);
    }
}
