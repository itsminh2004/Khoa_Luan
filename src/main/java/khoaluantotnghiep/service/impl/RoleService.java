package khoaluantotnghiep.service.impl;

import khoaluantotnghiep.Dao.IRoleDao;
import khoaluantotnghiep.service.IRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Service
public class RoleService  implements IRoleService {
    @Autowired
    private IRoleDao roleDao;

    private static final Map<String, String> AVAILABLE_ROLES=  new LinkedHashMap<>();
    static {
        AVAILABLE_ROLES.put("ADMIN", "Quản trị viên");
        AVAILABLE_ROLES.put("SALES_STAFF", "Nhân viên bán hàng");
        AVAILABLE_ROLES.put("WAREHOUSE_MANAGER", "Quản lý kho");
        AVAILABLE_ROLES.put("CONTENT_MANAGER", "Quản lý nội dung");

    }

    @Override
    public Map<String, String> getAvailableRoles() {
        return AVAILABLE_ROLES;
    }

    @Override
    public List<String> getUserRoles(int userId) {
        return roleDao.getRolesByUserId(userId);
    }

    @Override
    @Transactional
    public boolean updateUserRoles(int userId, List<String> roles) {
        try{
            roleDao.removeAllRoles(userId);
            if(roles==null||roles.isEmpty()){
                roleDao.assignRole(userId,"USER");
                return true;
            }
            for(String role:roles){
                if (AVAILABLE_ROLES.containsKey(role)) {
                    roleDao.assignRole(userId, role);
                }
            }
            return true;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean userHasRole(int userId, String role) {
        return roleDao.hasRole(userId, role);
    }
}
