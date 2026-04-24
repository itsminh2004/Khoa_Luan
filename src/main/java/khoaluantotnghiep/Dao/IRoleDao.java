package khoaluantotnghiep.Dao;

import java.util.List;

public interface IRoleDao {
    List<String> getRolesByUserId(int userId);
    boolean assignRole(int userId, String role);
    boolean removeRole(int userId, String role);
    boolean removeAllRoles(int userId);
    boolean hasRole(int userId, String role);
}
