package khoaluantotnghiep.config;

import khoaluantotnghiep.service.CustomUserDetailsService;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.Arrays;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {

        http
                .csrf().disable()
                .cors()
                .and()
                .sessionManagement()
                .sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED)
                .maximumSessions(1)
                .maxSessionsPreventsLogin(false)
                .and()
                .and()
                // Đảm bảo SecurityContext được lưu vào session
                .securityContext()
                .securityContextRepository(new HttpSessionSecurityContextRepository())
                .and()

                .authorizeRequests()
                .antMatchers(HttpMethod.GET, "/api/blog/**").permitAll()
                .antMatchers(HttpMethod.POST, "/api/blog/**").authenticated()
                .antMatchers(HttpMethod.DELETE, "/api/blog/**").authenticated()
                .antMatchers(
                        "/",
                        "/trang-chu",
                        "/login",
                        "/register",
                        "/verify",
                        "/forgot-password",
                        "/reset-password",
                        "/access-denied",

                        "/api/auth/**",
                        "/api/products/**",
                        "/api/categories/**",
                        "/api/brands/**",
                        "/api/series/**",
                        "/api/menu/**",
                        "/api/policies/**",
                        "/api/coupons/check",
                        "/api/chat",
                        "/api/payment/**",
                        "/api/products/*/reviews",
                        "/api/products/*/comments",
                        "/api/banners/**",

                        "/template/**",
                        "/assets/**",
                        "/uploads/**",
                        "/css/**",
                        "/js/**",
                        "/images/**")
                .permitAll()

                .antMatchers(HttpMethod.GET, "/api/blog/post/*/comments").permitAll()

                .antMatchers(HttpMethod.POST, "/api/blog/posts/*/comments").authenticated()

                .antMatchers(HttpMethod.DELETE, "/api/blog/comments/**").authenticated()

                // Phân quyền chi tiết cho admin
                // Dashboard - tất cả authenticated users
                .antMatchers("/admin-home").authenticated()

                // Revenue - chỉ ADMIN
                .antMatchers("/admin-revenue").hasRole("ADMIN")

                .antMatchers(HttpMethod.DELETE, "/api/product-images/**").hasAnyRole("ADMIN", "WAREHOUSE_MANAGER")

                // Product Management - ADMIN và WAREHOUSE_MANAGER
                .antMatchers("/admin-product/**", "/admin-category/**", "/admin-series/**", "/admin-brand/**")
                .hasAnyRole("ADMIN", "WAREHOUSE_MANAGER")

                // Stock/Warehouse - ADMIN và WAREHOUSE_MANAGER
                .antMatchers("/admin-stock/**")
                .hasAnyRole("ADMIN", "WAREHOUSE_MANAGER")

                // Orders - ADMIN và SALES_STAFF
                .antMatchers("/admin-orders/**")
                .hasAnyRole("ADMIN", "SALES_STAFF")

                // Coupons - ADMIN và SALES_STAFF
                .antMatchers("/admin-coupon/**")
                .hasAnyRole("ADMIN", "SALES_STAFF")

                // Blog Management - ADMIN và CONTENT_MANAGER
                .antMatchers("/admin-blog/**")
                .hasAnyRole("ADMIN", "CONTENT_MANAGER")

                // Policy - ADMIN và CONTENT_MANAGER
                .antMatchers("/admin-policy/**")
                .hasAnyRole("ADMIN", "CONTENT_MANAGER")

                // Reviews và Comments - ADMIN, SALES_STAFF, CONTENT_MANAGER
                .antMatchers("/admin-review/**", "/admin-product-comment/**")
                .hasAnyRole("ADMIN", "SALES_STAFF", "CONTENT_MANAGER")

                // Account Management và Roles - chỉ ADMIN
                .antMatchers("/admin-account/**", "/admin-roles/**", "/admin-profile-reset/")
                .hasRole("ADMIN")

                // API admin - chỉ ADMIN (có thể điều chỉnh sau)
                .antMatchers("/api/admin/**").hasRole("ADMIN")

                // Các trang admin khác - yêu cầu authenticated
                .antMatchers("/admin/**").authenticated()

                .antMatchers("/api/cart/**", "/api/wishlist/**", "/api/orders/**").authenticated()
                .anyRequest().authenticated()
                .and()

                .formLogin()
                .loginPage("/login")
                .loginProcessingUrl("/login")
                .usernameParameter("email")
                .passwordParameter("password")
                .defaultSuccessUrl("/admin-home", true)
                .failureUrl("/login?error=true")
                .permitAll()
                .and()

                .exceptionHandling()
                .accessDeniedHandler(new CustomAccessDeniedHandler())
                .and()

                .logout()
                .logoutUrl("/logout")
                .logoutSuccessUrl("/login?logout")
                .invalidateHttpSession(true)
                .deleteCookies("JSESSIONID");

        return http.build();
    }

    @Bean
    public AuthenticationManager authenticationManager(HttpSecurity http,
                                                       PasswordEncoder passwordEncoder,
                                                       CustomUserDetailsService customUserDetailsService) throws Exception {
        AuthenticationManagerBuilder builder = http.getSharedObject(AuthenticationManagerBuilder.class);
        builder.userDetailsService(customUserDetailsService).passwordEncoder(passwordEncoder);
        return builder.build();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration config = new CorsConfiguration();
        config.setAllowedOrigins(Arrays.asList(
                "http://localhost:5500",
                "http://127.0.0.1:5500",
                "http://localhost:8080",
                "http://127.0.0.1:8080"));
        config.setAllowedMethods(Arrays.asList("GET", "POST", "PUT", "DELETE", "OPTIONS"));
        config.setAllowedHeaders(Arrays.asList("*"));
        config.setAllowCredentials(true);

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", config);
        return source;
    }
}
