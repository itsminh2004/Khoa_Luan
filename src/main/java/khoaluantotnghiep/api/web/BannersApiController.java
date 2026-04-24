package khoaluantotnghiep.api.web;

import khoaluantotnghiep.dto.BannerDto;
import khoaluantotnghiep.model.Banner;
import khoaluantotnghiep.service.IBannerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/api")
public class BannersApiController {

    @Autowired
    private IBannerService bannerService;

    @RequestMapping(value = "/banners", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
    @ResponseBody
    public List<BannerDto> getBanners(@RequestParam(value = "position", required = false) String position) {
        // Sử dụng findActive để lấy các banner đang hoạt động và trong thời gian hiệu lực
        List<Banner> banners = bannerService.findActive(position);

        List<BannerDto> dtos = new ArrayList<>();
        if (banners != null) {
            for (Banner banner : banners) {
                dtos.add(new BannerDto(banner));
            }
        }
        return dtos;
    }
}
