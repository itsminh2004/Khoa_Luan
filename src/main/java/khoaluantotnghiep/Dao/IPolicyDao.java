package khoaluantotnghiep.Dao;

import khoaluantotnghiep.model.Policy;
import java.util.List;

public interface IPolicyDao {
    Policy insert(Policy policy);
    Policy update(Policy policy);
    void delete(int id);
    List<Policy> findAll();
    Policy findOne(int id);
    Policy findBySlug(String slug);
    List<Policy> findByType(String type);
}
