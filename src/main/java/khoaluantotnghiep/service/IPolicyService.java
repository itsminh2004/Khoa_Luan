package khoaluantotnghiep.service;

import khoaluantotnghiep.model.Policy;
import java.util.List;

public interface IPolicyService {
    Policy save(Policy policy);
    void delete(int id);
    List<Policy> findAll();
    Policy findOne(int id);
    Policy findBySlug(String slug);
}
