package khoaluantotnghiep.model;

public class AdminProfile {
    private int userId;

    // tb_users.full_name
    private String username;

    // tb_users.email
    private String email;

    // tb_user_address.phone
    private String phone;

    // tb_roles.role (hiển thị 1 role đầu tiên hoặc ghép nhiều role)
    private String role;

    // Địa chỉ mặc định (is_default = 1) ghép chuỗi: province/district/ward/specificAddress
    private String defaultAddressText;

    // Các trường địa chỉ để hiển thị & update
    private String province;
    private String district;
    private String ward;
    private String specificAddress;

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getDefaultAddressText() {
        return defaultAddressText;
    }

    public void setDefaultAddressText(String defaultAddressText) {
        this.defaultAddressText = defaultAddressText;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public String getWard() {
        return ward;
    }

    public void setWard(String ward) {
        this.ward = ward;
    }

    public String getSpecificAddress() {
        return specificAddress;
    }

    public void setSpecificAddress(String specificAddress) {
        this.specificAddress = specificAddress;
    }
}

