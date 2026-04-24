package khoaluantotnghiep.service;

import khoaluantotnghiep.model.UserAddress;
import java.util.List;

public interface IUserAddressService {
    List<UserAddress> getAddressesByUserId(int userId);
    UserAddress getAddressById(int id);
    boolean addAddress(UserAddress address);
    boolean updateAddress(UserAddress address);
    boolean deleteAddress(int id);
    void setDefault(int userId, int addressId);
}
