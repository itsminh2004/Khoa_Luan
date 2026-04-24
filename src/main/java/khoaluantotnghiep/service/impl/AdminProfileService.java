package khoaluantotnghiep.service.impl;

import khoaluantotnghiep.Dao.IAdminProfileDao;
import khoaluantotnghiep.model.AdminProfile;
import khoaluantotnghiep.model.User;
import khoaluantotnghiep.model.UserAddress;
import khoaluantotnghiep.service.IAdminProfileService;
import khoaluantotnghiep.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Locale;
import java.util.Set;

@Service
public class AdminProfileService implements IAdminProfileService {

    @Autowired
    private IAdminProfileDao adminProfileDao;

    @Autowired
    private IUserService userService;

    @Override
    public List<AdminProfile> getAllProfiles() {
        List<User> users = userService.getAllUsers();
        List<AdminProfile> profiles = new ArrayList<>();

        for (User u : users) {
            User user = adminProfileDao.getUserById(u.getId());
            UserAddress defaultAddress = adminProfileDao.getUserAddressByUserId(u.getId());

            AdminProfile profile = new AdminProfile();
            profile.setUserId(u.getId());

            // username/email lấy từ user kèm role (nếu null thì dùng user hiện có)
            profile.setUsername(user != null ? user.getFullName() : u.getFullName());
            profile.setEmail(user != null ? user.getEmail() : u.getEmail());

            // role lấy từ tb_roles
            if (user != null && user.getRoles() != null && !user.getRoles().isEmpty()) {
                profile.setRole(String.join(", ", user.getRoles()));
            } else {
                profile.setRole("USER");
            }

            // phone + địa chỉ mặc định
            if (defaultAddress != null) {
                profile.setPhone(defaultAddress.getPhone());

                String addressText = buildDefaultAddressText(defaultAddress);
                profile.setDefaultAddressText(addressText);

                profile.setProvince(defaultAddress.getProvince());
                profile.setDistrict(defaultAddress.getDistrict());
                profile.setWard(defaultAddress.getWard());
                profile.setSpecificAddress(defaultAddress.getSpecificAddress());
            } else {
                profile.setPhone("");
                profile.setDefaultAddressText("");
                profile.setProvince("");
                profile.setDistrict("");
                profile.setWard("");
                profile.setSpecificAddress("");
            }

            profiles.add(profile);
        }

        return profiles;
    }

    @Override
    public AdminProfile getProfileByUserId(int userId) {
        // Lấy thông tin user + role
        User user = adminProfileDao.getUserById(userId);
        // Lấy địa chỉ mặc định
        UserAddress defaultAddress = adminProfileDao.getUserAddressByUserId(userId);

        if (user == null) {
            return null;
        }

        AdminProfile profile = new AdminProfile();
        profile.setUserId(user.getId());
        profile.setUsername(user.getFullName());
        profile.setEmail(user.getEmail());

        if (user.getRoles() != null && !user.getRoles().isEmpty()) {
            profile.setRole(String.join(", ", user.getRoles()));
        } else {
            profile.setRole("USER");
        }

        if (defaultAddress != null) {
            profile.setPhone(defaultAddress.getPhone());
            profile.setDefaultAddressText(buildDefaultAddressText(defaultAddress));
            profile.setProvince(defaultAddress.getProvince());
            profile.setDistrict(defaultAddress.getDistrict());
            profile.setWard(defaultAddress.getWard());
            profile.setSpecificAddress(defaultAddress.getSpecificAddress());
        } else {
            profile.setPhone("");
            profile.setDefaultAddressText("");
            profile.setProvince("");
            profile.setDistrict("");
            profile.setWard("");
            profile.setSpecificAddress("");
        }

        return profile;
    }

    @Override
    public List<AdminProfile> searchProfiles(String keyword, String role) {
        List<AdminProfile> all = getAllProfiles();
        if (all == null || all.isEmpty()) {
            return Collections.emptyList();
        }

        String normalizedKeyword = keyword != null ? keyword.trim().toLowerCase(Locale.ROOT) : "";
        String normalizedRole = role != null ? role.trim() : "";

        boolean filterByKeyword = !normalizedKeyword.isEmpty();
        boolean filterByRole = !normalizedRole.isEmpty();

        List<AdminProfile> result = new ArrayList<>();
        for (AdminProfile p : all) {
            if (p == null) continue;

            boolean matchesKeyword = true;
            if (filterByKeyword) {
                matchesKeyword = containsIgnoreCase(p.getUsername(), normalizedKeyword)
                        || containsIgnoreCase(p.getEmail(), normalizedKeyword)
                        || containsIgnoreCase(p.getPhone(), normalizedKeyword)
                        || containsIgnoreCase(p.getDefaultAddressText(), normalizedKeyword);
            }

            boolean matchesRole = true;
            if (filterByRole) {
                matchesRole = containsRoleToken(p.getRole(), normalizedRole);
            }

            if (matchesKeyword && matchesRole) {
                result.add(p);
            }
        }

        return result;
    }

    @Override
    public List<String> getDistinctRoles() {
        List<AdminProfile> all = getAllProfiles();
        if (all == null || all.isEmpty()) {
            return Collections.emptyList();
        }

        Set<String> roles = new LinkedHashSet<>();
        for (AdminProfile p : all) {
            if (p == null) continue;
            String roleStr = p.getRole();
            if (roleStr == null) continue;

            String[] tokens = roleStr.split(",");
            for (String t : tokens) {
                if (t == null) continue;
                String token = t.trim();
                if (!token.isEmpty()) {
                    roles.add(token);
                }
            }
        }

        return new ArrayList<>(roles);
    }

    private boolean containsIgnoreCase(String value, String expectedLower) {
        if (value == null) return false;
        return value.toLowerCase(Locale.ROOT).contains(expectedLower);
    }

    private boolean containsRoleToken(String roleStr, String selectedRole) {
        if (roleStr == null || selectedRole == null) return false;

        String[] tokens = roleStr.split(",");
        for (String t : tokens) {
            if (t == null) continue;
            if (t.trim().equalsIgnoreCase(selectedRole)) {
                return true;
            }
        }
        return false;
    }

    private String buildDefaultAddressText(UserAddress address) {
        // Ghép chuỗi địa chỉ mặc định phục vụ hiển thị (không để logic trong JSP).
        StringBuilder sb = new StringBuilder();

        if (address.getProvince() != null && !address.getProvince().trim().isEmpty()) {
            sb.append(address.getProvince().trim());
        }
        if (address.getDistrict() != null && !address.getDistrict().trim().isEmpty()) {
            if (sb.length() > 0) sb.append(", ");
            sb.append(address.getDistrict().trim());
        }
        if (address.getWard() != null && !address.getWard().trim().isEmpty()) {
            if (sb.length() > 0) sb.append(", ");
            sb.append(address.getWard().trim());
        }
        if (address.getSpecificAddress() != null && !address.getSpecificAddress().trim().isEmpty()) {
            if (sb.length() > 0) sb.append(", ");
            sb.append(address.getSpecificAddress().trim());
        }

        return sb.toString();
    }

    @Override
    @Transactional
    public boolean updateProfile(
            int userId,
            String fullName,
            String email,
            String phone,
            String province,
            String district,
            String ward,
            String specificAddress
    ) {
        UserAddress address = new UserAddress();
        address.setPhone(phone);
        address.setProvince(province);
        address.setDistrict(district);
        address.setWard(ward);
        address.setSpecificAddress(specificAddress);
        // recipient_name dùng khi insert địa chỉ mới (nếu user chưa có address)
        address.setRecipientName(fullName);
        address.setDefault(true);

        return adminProfileDao.updateUser(userId, fullName, email, address);
    }

    @Override
    @Transactional
    public boolean changePassword(int userId, String oldPassword, String newPassword) {
        User user = adminProfileDao.getUserById(userId);
        if (user == null){
            return false;
        }
        return userService.changePassword(user.getEmail(),oldPassword, newPassword);
    }

    @Override
    public boolean resetPassword(int userId, String newPassword) {
        User user = adminProfileDao.getUserById(userId);
        if (user == null){
            return false;
        }
        return userService.adminResetPassword(user.getEmail(), newPassword);
    }
}

