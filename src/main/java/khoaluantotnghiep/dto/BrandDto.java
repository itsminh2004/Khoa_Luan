package khoaluantotnghiep.dto;

public class BrandDto {
    private int id;
    private String name;
    private String alias;
    private String logo;

    public BrandDto() {}

    public BrandDto(int id, String name, String alias, String logo) {
        this.id = id;
        this.name = name;
        this.alias = alias;
        this.logo = logo;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getAlias() { return alias; }
    public void setAlias(String alias) { this.alias = alias; }

    public String getLogo() { return logo; }
    public void setLogo(String logo) { this.logo = logo; }
}
