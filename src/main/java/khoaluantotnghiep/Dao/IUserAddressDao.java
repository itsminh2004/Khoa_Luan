package khoaluantotnghiep.Dao;

import khoaluantotnghiep.model.UserAddress;
import java.util.List;

public interface IUserAddressDao {
    List<UserAddress> findByUserId(int userId);
    UserAddress findById(int id);
    int create(UserAddress address);
    boolean update(UserAddress address);
    boolean delete(int id);
    void resetDefault(int userId);
}
