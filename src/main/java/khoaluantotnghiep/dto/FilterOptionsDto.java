package khoaluantotnghiep.dto;

import java.util.List;
import khoaluantotnghiep.model.Series;

public class FilterOptionsDto {
    private List<Series> seriesList;
    private List<String> ramList;
    private List<String> romList;

    public List<Series> getSeriesList() {
        return seriesList;
    }

    public void setSeriesList(List<Series> seriesList) {
        this.seriesList = seriesList;
    }

    public List<String> getRamList() {
        return ramList;
    }

    public void setRamList(List<String> ramList) {
        this.ramList = ramList;
    }

    public List<String> getRomList() {
        return romList;
    }

    public void setRomList(List<String> romList) {
        this.romList = romList;
    }
}
