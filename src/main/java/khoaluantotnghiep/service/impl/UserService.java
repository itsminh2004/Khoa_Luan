package khoaluantotnghiep.service.impl;

import khoaluantotnghiep.Dao.IUserDao;
import khoaluantotnghiep.model.User;
import khoaluantotnghiep.service.IEmailService;
import khoaluantotnghiep.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.security.SecureRandom;
import java.util.List;

@Service
public class UserService implements IUserService {

    @Autowired
    private IUserDao userDao;
    @Autowired
    private IEmailService emailService;
    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public User login(String email, String password) {
        User user = userDao.findByEmail(email);
        if (user != null && user.isEnabled() && passwordEncoder.matches(password, user.getPassword())) {
            return user;
        }
        return null;
    }

    @Override
    public User findByEmail(String email) {
        return userDao.findByEmail(email);
    }

    @Override
    public boolean saveVerificationCode(String email, String code) {
        return userDao.saveVerificationCode(email, code);
    }



    @Override
    public boolean registerAndSendOTP(String email, String fullName, String password) {
        String encodedPassword = passwordEncoder.encode(password);
        boolean registered = userDao.register(email, fullName, encodedPassword);
        if (registered) {
            SecureRandom rnd = new SecureRandom();
            int n = 100000 + rnd.nextInt(900000);
            String code = String.valueOf(n);
            boolean saved = userDao.saveVerificationCode(email, code);
            if (!saved) {
                return false;
            }
            boolean sent = emailService.sendEmail(email, "Mã xác nhận OTP", "Mã OTP của bạn: " + code);
            return sent;
        }
        return false;
    }
    @Override
    public User verifyOTP(String email, String code) {
        return userDao.verifyOTP(email, code);
    }
    @Override
    public List<User> getAllUsers() {
        return userDao.findAllUsers();
    }

    @Override
    public void delete(int id) {
        userDao.deleteUser(id);
    }

    @Override
    public void updateUserRole(int userId, String role) {
        userDao.updateUser(userId, role);
    }

    @Override
    public User findOne(int id) {
        return userDao.findOne(id);
    }

    @Override
    public boolean sendPasswordResetCode(String email) {
        User user = userDao.findByEmail(email);
        if (user == null) {
            return false;
        }
        // Tạo mã OTP 6 chữ số
        String code = String.valueOf((int)((Math.random()*9+1)*100000));
        // Lưu mã vào database
        boolean saved = userDao.saveVerificationCode(email, code);
        if (saved) {
            // Gửi email chứa mã OTP
            emailService.sendEmail(email, "Mã đặt lại mật khẩu",
                    "Mã đặt lại mật khẩu của bạn là: " + code + "\n\nMã này có hiệu lực trong 30 phút.");
            return true;
        }
        return false;
    }

    @Override
    public boolean resetPassword(String email, String code, String newPassword) {
        // Kiểm tra mã OTP
        boolean isValidCode = userDao.verifyResetCode(email, code);
        if (!isValidCode) {
            System.out.println("[DEBUG] Invalid reset code for email: " + email);
            return false;
        }
        // Cập nhật mật khẩu mới và xóa mã verification trong cùng một transaction
        String encodedPassword = passwordEncoder.encode(newPassword);
        boolean updated = userDao.updatePasswordAndClearCode(email, encodedPassword);
        if (updated) {
            System.out.println("[DEBUG] Password reset successful for email: " + email);
            return true;
        } else {
            System.out.println("[DEBUG] Failed to update password for email: " + email);
        }
        return false;
    }
}
