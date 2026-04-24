package khoaluantotnghiep.Dao.impl;

import khoaluantotnghiep.Dao.IPolicyDao;
import khoaluantotnghiep.mapper.PolicyMapper;
import khoaluantotnghiep.model.Policy;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public class PolicyDao implements IPolicyDao {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public Policy insert(Policy policy) {
        String sql = "INSERT INTO tb_policies (title, slug, content, type) VALUES (?, ?, ?, ?)";
        jdbcTemplate.update(sql, policy.getTitle(), policy.getSlug(), policy.getContent(), policy.getType());
        return findBySlug(policy.getSlug());
    }

    @Override
    public Policy update(Policy policy) {
        String sql = "UPDATE tb_policies SET title=?, slug=?, content=?, type=? WHERE id=?";
        jdbcTemplate.update(sql, policy.getTitle(), policy.getSlug(), policy.getContent(), policy.getType(), policy.getId());
        return policy;
    }

    @Override
    public void delete(int id) {
        jdbcTemplate.update("DELETE FROM tb_policies WHERE id=?", id);
    }

    @Override
    public List<Policy> findAll() {
        return jdbcTemplate.query("SELECT * FROM tb_policies", new PolicyMapper());
    }

    @Override
    public Policy findOne(int id) {
        try {
            return jdbcTemplate.queryForObject("SELECT * FROM tb_policies WHERE id=?", new PolicyMapper(), id);
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    @Override
    public Policy findBySlug(String slug) {
        try {
            return jdbcTemplate.queryForObject("SELECT * FROM tb_policies WHERE slug=?", new PolicyMapper(), slug);
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    @Override
    public List<Policy> findByType(String type) {
        return jdbcTemplate.query("SELECT * FROM tb_policies WHERE type=?", new PolicyMapper(), type);
    }
}
