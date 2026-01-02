package khoaluantotnghiep.Dao.impl;

import khoaluantotnghiep.Dao.ISeriesDao;
import khoaluantotnghiep.mapper.SeriesMapper;
import khoaluantotnghiep.model.Series;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Collections;
import java.util.List;
@Repository

public class SeriesDao implements ISeriesDao {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public Series findOne(int id) {
        String sql = "SELECT * FROM tb_series WHERE Id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, new SeriesMapper(), id);
        } catch (EmptyResultDataAccessException e) {
            return null;
        }
    }

    @Override
    public List<Series> findAll() {
        String sql = "SELECT * FROM tb_series ORDER BY Id DESC";
        return jdbcTemplate.query(sql, new SeriesMapper());
    }

    @Override
    public List<Series> findByCategoryId(int categoryId) {
        String sql = "SELECT * FROM tb_series WHERE CategoryId = ?";
        try {
            return jdbcTemplate.query(sql, new SeriesMapper(), categoryId);
        }catch (EmptyResultDataAccessException e){
            return  Collections.emptyList();
        }
    }

    @Override
    public Series insert(Series series) {
        String sql = "INSERT INTO tb_series (Name, CategoryId) VALUES (?, ?)";
        KeyHolder keyHolder = new GeneratedKeyHolder();
        jdbcTemplate.update(new PreparedStatementCreator(){
            @Override
            public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
                PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                ps.setString(1, series.getName());
                ps.setInt(2, series.getCategoryId());
                return ps;
            }
        }, keyHolder);
        if (keyHolder.getKey() != null) {
            series.setId(keyHolder.getKey().intValue());
        }
        return series;
    }

    @Override
    public Series update(Series series) {
        String sql = "UPDATE tb_series SET Name = ?, CategoryId = ? WHERE Id = ?";
        int row= jdbcTemplate.update(
                sql,
                series.getName(),series.getCategoryId(),series.getId());
        if (row == 0) {
            throw new RuntimeException("Record not found");
        }
        return series;
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM tb_series WHERE Id = ?";
        jdbcTemplate.update(sql,id);
    }
}
