package khoaluantotnghiep.service;

import java.util.List;
import java.util.Map;

public interface IRoleService {
    Map<String, String> getAvailableRoles();
    List<String> getUserRoles(int userId);
    boolean updateUserRoles(int userId, List<String> roles);
    boolean userHasRole(int userId, String role);
}
