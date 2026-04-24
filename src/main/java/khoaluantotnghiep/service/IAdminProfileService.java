package khoaluantotnghiep.service;

import khoaluantotnghiep.model.AdminProfile;

import java.util.List;


public interface IAdminProfileService {
    List<AdminProfile> getAllProfiles();
    AdminProfile getProfileByUserId(int userId);
    List<AdminProfile> searchProfiles(String keyword, String role);
    List<String> getDistinctRoles();
    boolean updateProfile(
            int userId,
            String fullName,
            String email,
            String phone,
            String province,
            String district,
            String ward,
            String specificAddress
    );
    boolean changePassword(int userId, String oldPassword, String newPassword);
    boolean resetPassword(int userId, String newPassword);
}

