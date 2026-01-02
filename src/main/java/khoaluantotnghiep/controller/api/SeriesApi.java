package khoaluantotnghiep.controller.api;

import khoaluantotnghiep.model.Series;
import khoaluantotnghiep.service.ISeriesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/series")
public class SeriesApi {
    @Autowired
    private ISeriesService seriesService;
    @GetMapping("/byCategory/{categoryId}")
    public List<Series> getSeriesByCategory(@PathVariable("categoryId") int categoryId) {
        return seriesService.findByCategoryId(categoryId);
    }

    @GetMapping
    public List<Series> getAllSeries() {
        return seriesService.findAll();
    }
}
