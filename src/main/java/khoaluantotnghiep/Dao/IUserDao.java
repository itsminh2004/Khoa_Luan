package khoaluantotnghiep.Dao;

import khoaluantotnghiep.model.User;

import java.util.List;

public interface IUserDao {
    User login(String email, String password);
    User findByEmail(String email);
    boolean saveVerificationCode(String email, String code);
    User verifyOTP(String email, String code);
    boolean register(String email,String fullName, String password);
    List<User> findAllUsers();
    void updateUser(int userId, String role);
    void deleteUser(int userId);
    User findOne(int id);
    boolean updatePassword(String email, String newPassword);
    boolean verifyResetCode(String email, String code);
    boolean updatePasswordAndClearCode(String email, String newPassword);
}
