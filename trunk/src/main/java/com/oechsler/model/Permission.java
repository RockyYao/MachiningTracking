package com.oechsler.model;

import java.util.List;

public class Permission {
    private Integer id;

    private String name;

    private String pUrl;

    private Integer pLevel;

    private Integer parentId;

    private Boolean checked;

    private Integer open;

    private String pIcon;

    private Integer sort;

    private List<Permission> childList;

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    public String getpIcon() {
        return pIcon;
    }

    public void setpIcon(String pIcon) {
        this.pIcon = pIcon;
    }

    public List<Permission> getChildList() {
        return childList;
    }

    public void setChildList(List<Permission> childList) {
        this.childList = childList;
    }

    public Integer getOpen() {
        return open;
    }

    public void setOpen(Integer open) {
        this.open = open;
    }

    public Boolean getChecked() {
        return checked;
    }

    public void setChecked(Boolean checked) {
        this.checked = checked;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getpUrl() {
        return pUrl;
    }

    public void setpUrl(String pUrl) {
        this.pUrl = pUrl;
    }

    public Integer getpLevel() {
        return pLevel;
    }

    public void setpLevel(Integer pLevel) {
        this.pLevel = pLevel;
    }

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }
}