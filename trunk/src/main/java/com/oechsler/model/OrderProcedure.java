package com.oechsler.model;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

public class OrderProcedure {
    private Integer id;

    private Integer createBy;

    private Date createTime;

    private Integer updateBy;

    private Date updateTime;

    private Integer deleted;

    private String enName;

    private String chName;

    private Integer status;

    private String sort;

    private String preCostTime;

    private String relCostTime;

    private String dwgNo;


    private String formatRelCostTime;

    private List<OrderProcedureLog> procedureLogList;

    public List<OrderProcedureLog> getProcedureLogList() {
        return procedureLogList;
    }

    public void setProcedureLogList(List<OrderProcedureLog> procedureLogList) {
        this.procedureLogList = procedureLogList;
    }



    public String getFormatRelCostTime() {
        return formatRelCostTime;
    }

    public void setFormatRelCostTime(String formatRelCostTime) {
        this.formatRelCostTime = formatRelCostTime;
    }
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getCreateBy() {
        return createBy;
    }

    public void setCreateBy(Integer createBy) {
        this.createBy = createBy;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getUpdateBy() {
        return updateBy;
    }

    public void setUpdateBy(Integer updateBy) {
        this.updateBy = updateBy;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public Integer getDeleted() {
        return deleted;
    }

    public void setDeleted(Integer deleted) {
        this.deleted = deleted;
    }

    public String getEnName() {
        return enName;
    }

    public void setEnName(String enName) {
        this.enName = enName == null ? null : enName.trim();
    }

    public String getChName() {
        return chName;
    }

    public void setChName(String chName) {
        this.chName = chName == null ? null : chName.trim();
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getSort() {
        return sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }

    public String getPreCostTime() {
        return preCostTime;
    }

    public void setPreCostTime(String preCostTime) {
        this.preCostTime = preCostTime;
    }

    public String getRelCostTime() {
        return relCostTime;
    }

    public void setRelCostTime(String relCostTime) {
        this.relCostTime = relCostTime;
    }

    public String getDwgNo() {
        return dwgNo;
    }

    public void setDwgNo(String dwgNo) {
        this.dwgNo = dwgNo;
    }
}