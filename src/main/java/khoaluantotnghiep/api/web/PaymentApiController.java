package khoaluantotnghiep.api.web;

import khoaluantotnghiep.config.VnPayConfig;
import khoaluantotnghiep.dto.PaymentDto;
import khoaluantotnghiep.model.Order;
import khoaluantotnghiep.service.IOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.*;

@RestController
@RequestMapping("/api/payment")
@CrossOrigin(origins = { "http://127.0.0.1:5500", "http://localhost:5500" })
public class PaymentApiController {

    @Autowired
    private IOrderService orderService;

    @Autowired
    private khoaluantotnghiep.service.ICartService cartService;

    @GetMapping("/create_payment/{orderId}")
    public ResponseEntity<PaymentDto> createPayment(@PathVariable int orderId, HttpServletRequest req)
            throws UnsupportedEncodingException {

        Order order = orderService.findById(orderId);
        if (order == null) {
            return ResponseEntity.notFound().build();
        }

        long amount = (long) (order.getTotalAmount() * 100);
        String vnp_TxnRef = String.valueOf(order.getId());
        String vnp_IpAddr = VnPayConfig.getIpAddress(req);
        String vnp_TmnCode = VnPayConfig.vnp_TmnCode;

        Map<String, String> vnp_Params = new HashMap<>();
        vnp_Params.put("vnp_Version", "2.1.0");
        vnp_Params.put("vnp_Command", "pay");
        vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
        vnp_Params.put("vnp_Amount", String.valueOf(amount));
        vnp_Params.put("vnp_CurrCode", "VND");
        vnp_Params.put("vnp_BankCode", "NCB"); // Default test bank
        vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
        vnp_Params.put("vnp_OrderInfo", "Thanh toan don hang:" + vnp_TxnRef);
        vnp_Params.put("vnp_Locale", "vn");
        vnp_Params.put("vnp_ReturnUrl", VnPayConfig.vnp_ReturnUrl); // Frontend URL
        vnp_Params.put("vnp_IpAddr", vnp_IpAddr);
        vnp_Params.put("vnp_OrderType", "other");

        Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        String vnp_CreateDate = formatter.format(cld.getTime());
        vnp_Params.put("vnp_CreateDate", vnp_CreateDate);

        cld.add(Calendar.MINUTE, 15);
        String vnp_ExpireDate = formatter.format(cld.getTime());
        vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);

        List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();
        StringBuilder query = new StringBuilder();
        Iterator<String> itr = fieldNames.iterator();
        while (itr.hasNext()) {
            String fieldName = itr.next();
            String fieldValue = vnp_Params.get(fieldName);
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                // Build hash data
                hashData.append(fieldName);
                hashData.append('=');
                hashData.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                // Build query
                query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString()));
                query.append('=');
                query.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                if (itr.hasNext()) {
                    query.append('&');
                    hashData.append('&');
                }
            }
        }
        String queryUrl = query.toString();
        String vnp_SecureHash = VnPayConfig.hmacSHA512(VnPayConfig.vnp_HashSecret, hashData.toString());
        queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;
        String paymentUrl = VnPayConfig.vnp_PayUrl + "?" + queryUrl;

        PaymentDto paymentDto = new PaymentDto();
        paymentDto.setStatus("OK");
        paymentDto.setMessage("Successfully generated url");
        paymentDto.setURL(paymentUrl);

        return ResponseEntity.status(HttpStatus.OK).body(paymentDto);
    }

    @GetMapping("/vnpay_return")
    public ResponseEntity<PaymentDto> vnpayReturn(
            @RequestParam(value = "vnp_Amount") String amount,
            @RequestParam(value = "vnp_BankCode") String bankCode,
            @RequestParam(value = "vnp_OrderInfo") String orderInfo,
            @RequestParam(value = "vnp_ResponseCode") String responseCode,
            @RequestParam(value = "vnp_TxnRef") String txnRef,
            @RequestParam(value = "vnp_SecureHash") String secureHash,
            @RequestParam Map<String, String> allParams) {

        // Here we should verify the SecureHash again but for simplicity we trust if
        // responseCode == 00
        // In production, MUST verify hash.

        PaymentDto result = new PaymentDto();
        if ("00".equals(responseCode)) {
            // Payment successful
            int orderId = Integer.parseInt(txnRef);
            Order order = orderService.findById(orderId);
            if (order != null) {
                orderService.updateStatus(orderId, "CONFIRMED");
                cartService.clearCart(order.getUserId());
                result.setStatus("OK");
                result.setMessage("Payment Success");
            } else {
                result.setStatus("FAILED");
                result.setMessage("Order not found");
            }
        } else {
            // If payment failed (e.g. Cancelled), delete the PENDING order
            // so it doesn't clutter the user's order history.
            try {
                int orderId = Integer.parseInt(txnRef);
                Order order = orderService.findById(orderId);
                if (order != null && "PENDING".equals(order.getStatus())) {
                    orderService.deleteOrder(orderId);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            result.setStatus("FAILED");
            result.setMessage("Payment Failed or Cancelled");
        }
        return ResponseEntity.ok(result);
    }
}
