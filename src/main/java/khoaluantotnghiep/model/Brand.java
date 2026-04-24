package khoaluantotnghiep.model;

public class Brand {
    private int id;
    private String name;
    private String alias;
    private String logo;
    private boolean active;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getAlias() { return alias; }
    public void setAlias(String alias) { this.alias = alias; }

    public String getLogo() { return logo; }
    public void setLogo(String logo) { this.logo = logo; }

    public boolean isActive() { return active; }
    public void setActive(boolean active) { this.active = active; }
}