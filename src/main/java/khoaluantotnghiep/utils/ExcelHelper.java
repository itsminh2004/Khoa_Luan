package khoaluantotnghiep.utils;

import khoaluantotnghiep.model.*;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.multipart.MultipartFile;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class ExcelHelper {
    public static String TYPE = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";

    // Product Headers
    static String[] PRODUCT_HEADERS = { "Name", "Description", "Price", "PriceSale", "Stock", "Category", "Series", "Brand", "Alias", "Active" };
    static String PRODUCT_SHEET = "Products";

    // RootCategory Headers
    static String[] ROOT_CATEGORY_HEADERS = { "Name", "Description", "Image", "Alias" };
    static String ROOT_CATEGORY_SHEET = "RootCategories";

    // ProductCategory Headers
    static String[] PRODUCT_CATEGORY_HEADERS = { "Name", "Description", "Image", "Alias", "RootCategory" };
    static String PRODUCT_CATEGORY_SHEET = "ProductCategories";

    // Series Headers
    static String[] SERIES_HEADERS = { "Name", "Category" };
    static String SERIES_SHEET = "Series";

    // Brand Headers
    static String[] BRAND_HEADERS = { "Name", "Alias", "Logo", "Active" };
    static String BRAND_SHEET = "Brands";

    public static boolean hasExcelFormat(MultipartFile file) {
        if (!TYPE.equals(file.getContentType())) {
            return false;
        }
        return true;
    }

    // --- Product Methods ---
    public static List<Product> excelToProducts(InputStream is) {
        try (Workbook workbook = new XSSFWorkbook(is)) {
            Sheet sheet = workbook.getSheet(PRODUCT_SHEET);
            if (sheet == null) sheet = workbook.getSheetAt(0);

            Iterator<Row> rows = sheet.iterator();
            List<Product> products = new ArrayList<>();

            int rowNumber = 0;
            DataFormatter formatter = new DataFormatter();
            while (rows.hasNext()) {
                Row currentRow = rows.next();
                if (rowNumber == 0) { rowNumber++; continue; }

                Product product = new Product();
                int cellIdx = 0;
                Iterator<Cell> cellsInRow = currentRow.iterator();

                while (cellsInRow.hasNext()) {
                    Cell currentCell = cellsInRow.next();
                    switch (cellIdx) {
                        case 0: product.setName(formatter.formatCellValue(currentCell)); break;
                        case 1: product.setDescription(formatter.formatCellValue(currentCell)); break;
                        case 2: product.setPrice(getNumericValue(currentCell)); break;
                        case 3: product.setPriceSale(getNumericValue(currentCell)); break;
                        case 4: product.setStock((int) getNumericValue(currentCell)); break;
                        case 5: product.setCategoryName(formatter.formatCellValue(currentCell)); break;
                        case 6: product.setSeriesName(formatter.formatCellValue(currentCell)); break;
                        case 7: product.setBrandName(formatter.formatCellValue(currentCell)); break;
                        case 8: product.setAlias(formatter.formatCellValue(currentCell)); break;
                        case 9: product.setActive(getNumericValue(currentCell) == 1 || formatter.formatCellValue(currentCell).equalsIgnoreCase("true")); break;
                        default: break;
                    }
                    cellIdx++;
                }
                products.add(product);
            }
            return products;
        } catch (IOException e) {
            throw new RuntimeException("fail to parse Excel file: " + e.getMessage());
        }
    }

    public static ByteArrayInputStream productsToExcel(List<Product> products) {
        return listToExcel(products, PRODUCT_HEADERS, PRODUCT_SHEET, (product, row) -> {
            row.createCell(0).setCellValue(product.getName());
            row.createCell(1).setCellValue(product.getDescription());
            row.createCell(2).setCellValue(product.getPrice());
            row.createCell(3).setCellValue(product.getPriceSale());
            row.createCell(4).setCellValue(product.getStock());
            row.createCell(5).setCellValue(product.getCategoryName());
            row.createCell(6).setCellValue(product.getSeriesName());
            row.createCell(7).setCellValue(product.getBrandName());
            row.createCell(8).setCellValue(product.getAlias());
            row.createCell(9).setCellValue(product.isActive() ? 1 : 0);
        });
    }

    // --- RootCategory Methods ---
    public static List<RootCategory> excelToRootCategories(InputStream is) {
        return excelToList(is, ROOT_CATEGORY_SHEET, (row, formatter) -> {
            RootCategory item = new RootCategory();
            item.setName(formatter.formatCellValue(row.getCell(0)));
            item.setDescription(formatter.formatCellValue(row.getCell(1)));
            item.setImage(formatter.formatCellValue(row.getCell(2)));
            item.setAlias(formatter.formatCellValue(row.getCell(3)));
            return item;
        });
    }

    public static ByteArrayInputStream rootCategoriesToExcel(List<RootCategory> items) {
        return listToExcel(items, ROOT_CATEGORY_HEADERS, ROOT_CATEGORY_SHEET, (item, row) -> {
            row.createCell(0).setCellValue(item.getName());
            row.createCell(1).setCellValue(item.getDescription());
            row.createCell(2).setCellValue(item.getImage());
            row.createCell(3).setCellValue(item.getAlias());
        });
    }

    // --- ProductCategory Methods ---
    public static List<ProductCategory> excelToProductCategories(InputStream is) {
        return excelToList(is, PRODUCT_CATEGORY_SHEET, (row, formatter) -> {
            ProductCategory item = new ProductCategory();
            item.setName(formatter.formatCellValue(row.getCell(0)));
            item.setDescription(formatter.formatCellValue(row.getCell(1)));
            item.setImage(formatter.formatCellValue(row.getCell(2)));
            item.setAlias(formatter.formatCellValue(row.getCell(3)));
            item.setRootCategoryName(formatter.formatCellValue(row.getCell(4)));
            return item;
        });
    }

    public static ByteArrayInputStream productCategoriesToExcel(List<ProductCategory> items) {
        return listToExcel(items, PRODUCT_CATEGORY_HEADERS, PRODUCT_CATEGORY_SHEET, (item, row) -> {
            row.createCell(0).setCellValue(item.getName());
            row.createCell(1).setCellValue(item.getDescription());
            row.createCell(2).setCellValue(item.getImage());
            row.createCell(3).setCellValue(item.getAlias());
            row.createCell(4).setCellValue(item.getRootCategoryName());
        });
    }

    // --- Series Methods ---
    public static List<Series> excelToSeries(InputStream is) {
        return excelToList(is, SERIES_SHEET, (row, formatter) -> {
            Series item = new Series();
            item.setName(formatter.formatCellValue(row.getCell(0)));
            item.setCategoryName(formatter.formatCellValue(row.getCell(1)));
            return item;
        });
    }

    public static ByteArrayInputStream seriesToExcel(List<Series> items) {
        return listToExcel(items, SERIES_HEADERS, SERIES_SHEET, (item, row) -> {
            row.createCell(0).setCellValue(item.getName());
            row.createCell(1).setCellValue(item.getCategoryName());
        });
    }

    // --- Brand Methods ---
    public static List<Brand> excelToBrands(InputStream is) {
        return excelToList(is, BRAND_SHEET, (row, formatter) -> {
            Brand item = new Brand();
            item.setName(formatter.formatCellValue(row.getCell(0)));
            item.setAlias(formatter.formatCellValue(row.getCell(1)));
            item.setLogo(formatter.formatCellValue(row.getCell(2)));
            item.setActive(getNumericValue(row.getCell(3)) == 1 || formatter.formatCellValue(row.getCell(3)).equalsIgnoreCase("true"));
            return item;
        });
    }

    public static ByteArrayInputStream brandsToExcel(List<Brand> items) {
        return listToExcel(items, BRAND_HEADERS, BRAND_SHEET, (item, row) -> {
            row.createCell(0).setCellValue(item.getName());
            row.createCell(1).setCellValue(item.getAlias());
            row.createCell(2).setCellValue(item.getLogo());
            row.createCell(3).setCellValue(item.isActive() ? 1 : 0);
        });
    }

    // --- Generic Utilities ---

    @FunctionalInterface
    private interface RowMapper<T> {
        T map(Row row, DataFormatter formatter);
    }

    @FunctionalInterface
    private interface RowWriter<T> {
        void write(T item, Row row);
    }

    private static <T> List<T> excelToList(InputStream is, String sheetName, RowMapper<T> mapper) {
        try (Workbook workbook = new XSSFWorkbook(is)) {
            Sheet sheet = workbook.getSheet(sheetName);
            if (sheet == null) sheet = workbook.getSheetAt(0);
            Iterator<Row> rows = sheet.iterator();
            List<T> list = new ArrayList<>();
            DataFormatter formatter = new DataFormatter();
            int rowNumber = 0;
            while (rows.hasNext()) {
                Row currentRow = rows.next();
                if (rowNumber == 0) { rowNumber++; continue; }
                list.add(mapper.map(currentRow, formatter));
            }
            return list;
        } catch (IOException e) {
            throw new RuntimeException("fail to parse Excel file: " + e.getMessage());
        }
    }

    private static <T> ByteArrayInputStream listToExcel(List<T> list, String[] headers, String sheetName, RowWriter<T> writer) {
        try (Workbook workbook = new XSSFWorkbook(); ByteArrayOutputStream out = new ByteArrayOutputStream()) {
            Sheet sheet = workbook.createSheet(sheetName);
            Row headerRow = sheet.createRow(0);
            CellStyle headerStyle = workbook.createCellStyle();
            Font font = workbook.createFont();
            font.setBold(true);
            headerStyle.setFont(font);

            for (int col = 0; col < headers.length; col++) {
                Cell cell = headerRow.createCell(col);
                cell.setCellValue(headers[col]);
                cell.setCellStyle(headerStyle);
            }

            int rowIdx = 1;
            for (T item : list) {
                Row row = sheet.createRow(rowIdx++);
                writer.write(item, row);
            }

            for (int i = 0; i < headers.length; i++) {
                sheet.autoSizeColumn(i);
            }

            workbook.write(out);
            return new ByteArrayInputStream(out.toByteArray());
        } catch (IOException e) {
            throw new RuntimeException("fail to export data to Excel file: " + e.getMessage());
        }
    }

    private static double getNumericValue(Cell cell) {
        if (cell == null || cell.getCellType() == CellType.BLANK) {
            return 0;
        }
        if (cell.getCellType() == CellType.NUMERIC) {
            return cell.getNumericCellValue();
        }
        if (cell.getCellType() == CellType.STRING) {
            try {
                return Double.parseDouble(cell.getStringCellValue());
            } catch (NumberFormatException e) {
                return 0;
            }
        }
        return 0;
    }
}
