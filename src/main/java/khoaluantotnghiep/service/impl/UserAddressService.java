package khoaluantotnghiep.service.impl;

import khoaluantotnghiep.Dao.IUserAddressDao;
import khoaluantotnghiep.model.UserAddress;
import khoaluantotnghiep.service.IUserAddressService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class UserAddressService implements IUserAddressService {

    @Autowired
    private IUserAddressDao addressDao;

    @Override
    public List<UserAddress> getAddressesByUserId(int userId) {
        return addressDao.findByUserId(userId);
    }

    @Override
    public UserAddress getAddressById(int id) {
        return addressDao.findById(id);
    }

    @Override
    @Transactional
    public boolean addAddress(UserAddress address) {
        if (address.isDefault()) {
            addressDao.resetDefault(address.getUserId());
        }
        // If it's the first address, make it default
        List<UserAddress> existing = addressDao.findByUserId(address.getUserId());
        if (existing.isEmpty()) {
            address.setDefault(true);
        }
        return addressDao.create(address) > 0;
    }

    @Override
    @Transactional
    public boolean updateAddress(UserAddress address) {
        if (address.isDefault()) {
            addressDao.resetDefault(address.getUserId());
        }
        return addressDao.update(address);
    }

    @Override
    public boolean deleteAddress(int id) {
        return addressDao.delete(id);
    }

    @Override
    @Transactional
    public void setDefault(int userId, int addressId) {
        addressDao.resetDefault(userId);
        UserAddress address = addressDao.findById(addressId);
        if (address != null && address.getUserId() == userId) {
            address.setDefault(true);
            addressDao.update(address);
        }
    }
}
