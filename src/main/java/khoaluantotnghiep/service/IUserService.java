package khoaluantotnghiep.service;

import khoaluantotnghiep.model.User;

import java.util.List;

public interface IUserService {

    User login(String email, String password);

    User findByEmail(String email);
    boolean saveVerificationCode(String email, String code);
    boolean registerAndSendOTP(String email, String fullName, String password);
    User verifyOTP(String email, String code);
    List<User> getAllUsers();
    void delete(int id);
    void updateUserRole(int userId, String role);
    User findOne(int id);
    boolean sendPasswordResetCode(String email);
    boolean resetPassword(String email, String code, String newPassword);
}
