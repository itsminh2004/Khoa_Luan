package khoaluantotnghiep;

import com.opensymphony.module.sitemesh.filter.PageFilter;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
public class KhoaLuanTotNghiepApplication {
    public static void main(String[] args) {
        SpringApplication.run(KhoaLuanTotNghiepApplication.class, args);
    }
    @Bean
    public FilterRegistrationBean<PageFilter> sitemeshFilter() {
        FilterRegistrationBean<PageFilter> reg = new FilterRegistrationBean<>();
        reg.setFilter(new PageFilter());
        reg.addUrlPatterns("/*");
        reg.setName("sitemeshFilter");
        reg.setOrder(1);
        return reg;
    }
}

