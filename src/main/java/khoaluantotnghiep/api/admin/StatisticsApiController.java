package khoaluantotnghiep.api.admin;

import khoaluantotnghiep.service.IOrderService;
import khoaluantotnghiep.service.IProductService;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/api/admin/statistics")
public class StatisticsApiController {

    @Autowired
    private IOrderService orderService;
    @Autowired
    private IProductService productService;

    @RequestMapping(value = "/summary", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
    @ResponseBody
    public Map<String, Object> getSummary() {
        Map<String, Object> summary = new HashMap<>();
        summary.put("totalOrders", orderService.getTotalOrders());
        summary.put("totalRevenue", orderService.getTotalRevenue());
        summary.put("totalProducts", productService.countAll());
        return summary;
    }

    @RequestMapping(value = "/top-selling", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
    @ResponseBody
    public List<Map<String, Object>> getTopSelling(@RequestParam(value = "limit", defaultValue = "5") int limit) {
        return orderService.getTopSellingProducts(limit);
    }

    @RequestMapping(value = "/daily-revenue-range", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
    @ResponseBody
    public List<Map<String, Object>> getDailyRevenue(@RequestParam(value = "days", defaultValue = "30") int days) {
        return orderService.getDailyRevenue(days);
    }

    @RequestMapping(value = "/daily-revenue-month", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
    @ResponseBody
    public List<Map<String, Object>> getDailyRevenueByMonth(
            @RequestParam("year") int year,
            @RequestParam("month") int month) {
        return orderService.getDailyRevenueByMonth(year, month);
    }

    @RequestMapping(value = "/export-excel", method = RequestMethod.GET)
    public ResponseEntity<byte[]> exportExcel(
            @RequestParam("year") int year,
            @RequestParam("month") int month) {

        List<Map<String, Object>> productSales = orderService.getProductsSalesByMonth(year, month);
        double totalRevenue = orderService.getMonthlyRevenue(year, month);

        try (Workbook workbook = new XSSFWorkbook(); ByteArrayOutputStream out = new ByteArrayOutputStream()) {
            Sheet sheet = workbook.createSheet("Báo cáo doanh số tháng " + month + "-" + year);

            // Font & Style for header
            Font headerFont = workbook.createFont();
            headerFont.setBold(true);
            headerFont.setColor(IndexedColors.WHITE.getIndex());

            CellStyle headerStyle = workbook.createCellStyle();
            headerStyle.setFont(headerFont);
            headerStyle.setFillForegroundColor(IndexedColors.BLUE.getIndex());
            headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            headerStyle.setAlignment(HorizontalAlignment.CENTER);

            // Row 0: Title
            Row titleRow = sheet.createRow(0);
            Cell titleCell = titleRow.createCell(0);
            titleCell.setCellValue("BÁO CÁO DOANH SỐ THÁNG " + month + "/" + year);
            CellStyle titleStyle = workbook.createCellStyle();
            Font titleFont = workbook.createFont();
            titleFont.setBold(true);
            titleFont.setFontHeightInPoints((short) 16);
            titleStyle.setFont(titleFont);
            titleCell.setCellStyle(titleStyle);

            // Row 2: Summary
            Row summaryRow = sheet.createRow(2);
            summaryRow.createCell(0).setCellValue("Tổng doanh thu:");
            summaryRow.createCell(1).setCellValue(totalRevenue);

            // Row 4: Header for product table
            Row headerRow = sheet.createRow(4);
            String[] columns = { "ID", "Tên sản phẩm", "Số lượng bán", "Doanh thu (VNĐ)" };
            for (int i = 0; i < columns.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(columns[i]);
                cell.setCellStyle(headerStyle);
            }

            // Data rows
            int rowIdx = 5;
            for (Map<String, Object> sale : productSales) {
                Row row = sheet.createRow(rowIdx++);
                row.createCell(0).setCellValue(sale.get("Id").toString());
                row.createCell(1).setCellValue(sale.get("Name").toString());
                row.createCell(2).setCellValue(Double.parseDouble(sale.get("total_sold").toString()));
                row.createCell(3).setCellValue(Double.parseDouble(sale.get("total_revenue").toString()));
            }

            for (int i = 0; i < columns.length; i++) {
                sheet.autoSizeColumn(i);
            }

            workbook.write(out);
            byte[] bytes = out.toByteArray();

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
            headers.setContentDispositionFormData("attachment", "Bao_cao_doanh_so_" + month + "_" + year + ".xlsx");

            return new ResponseEntity<>(bytes, headers, HttpStatus.OK);

        } catch (IOException e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
