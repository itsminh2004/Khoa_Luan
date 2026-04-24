package khoaluantotnghiep.Dao;

import khoaluantotnghiep.model.User;
import khoaluantotnghiep.model.UserAddress;


public interface IAdminProfileDao {
    User getUserById(int userId);
    UserAddress getUserAddressByUserId(int userId);
    boolean updateUser(int userId, String fullName, String email, UserAddress address);
}

