package com.oechsler.model;

import java.math.BigDecimal;
import java.util.Date;

public class Order {
    private Integer id;

    private Integer createBy;

    private Date createTime;

    private Integer updateBy;

    private Date updateTime;

    private Integer deleted;

    private String jobNo;

    private String dwgNo;

    private String rev;

    private String orderQty;

    private String plot;

    private String prodQty;

    private Integer status;

    private String preCostTime;

    private String relCostTime;

    private String currentProcedure;

    private String barCode;

    private String sameDwgNo;

    private String formatRelCostTime;

    private String currentSort;

    private Date targetDate;

    private String initiator;

    private Date initiatorDate;

    private BigDecimal completePercent;

    private String newDwgNo;

    public BigDecimal getCompletePercent() {
        return completePercent;
    }

    public String getNewDwgNo() {
        return newDwgNo;
    }

    public void setNewDwgNo(String newDwgNo) {
        this.newDwgNo = newDwgNo;
    }

    public void setCompletePercent() {
        BigDecimal preCostTimeB = new BigDecimal(this.preCostTime);
        //预估工时分钟
        BigDecimal preCostTimeMin = preCostTimeB.multiply(new BigDecimal("60"));
        BigDecimal relCostTimeB = new BigDecimal(this.relCostTime);
        //实际工时分钟
        BigDecimal relCostTimeSS = relCostTimeB.divide(new BigDecimal("1000"),4, BigDecimal.ROUND_UP);
        BigDecimal relCostTimeMin = relCostTimeSS.divide(new BigDecimal("60"),4, BigDecimal.ROUND_UP);
        this.completePercent = relCostTimeMin.divide(preCostTimeMin,2, BigDecimal.ROUND_UP).multiply(new BigDecimal("100"));
    }

    public Date getTargetDate() {
        return targetDate;
    }

    public void setTargetDate(Date targetDate) {
        this.targetDate = targetDate;
    }

    public String getInitiator() {
        return initiator;
    }

    public void setInitiator(String initiator) {
        this.initiator = initiator;
    }

    public Date getInitiatorDate() {
        return initiatorDate;
    }

    public void setInitiatorDate(Date initiatorDate) {
        this.initiatorDate = initiatorDate;
    }

    public String getCurrentSort() {
        return currentSort;
    }

    public void setCurrentSort(String currentSort) {
        this.currentSort = currentSort;
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

    public String getJobNo() {
        return jobNo;
    }

    public void setJobNo(String jobNo) {
        this.jobNo = jobNo == null ? null : jobNo.trim();
    }

    public String getDwgNo() {
        return dwgNo;
    }

    public void setDwgNo(String dwgNo) {
        this.dwgNo = dwgNo == null ? null : dwgNo.trim();
    }

    public String getRev() {
        return rev;
    }

    public void setRev(String rev) {
        this.rev = rev == null ? null : rev.trim();
    }

    public String getOrderQty() {
        return orderQty;
    }

    public void setOrderQty(String orderQty) {
        this.orderQty = orderQty == null ? null : orderQty.trim();
    }

    public String getPlot() {
        return plot;
    }

    public void setPlot(String plot) {
        this.plot = plot;
    }

    public String getProdQty() {
        return prodQty;
    }

    public void setProdQty(String prodQty) {
        this.prodQty = prodQty == null ? null : prodQty.trim();
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
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
        this.setCompletePercent();
    }

    public String getCurrentProcedure() {
        return currentProcedure;
    }

    public void setCurrentProcedure(String currentProcedure) {
        this.currentProcedure = currentProcedure;
    }

    public String getBarCode() {
        return barCode;
    }

    public void setBarCode(String barCode) {
        this.barCode = barCode == null ? null : barCode.trim();
    }

    public String getSameDwgNo() {
        return sameDwgNo;
    }

    public void setSameDwgNo(String sameDwgNo) {
        this.sameDwgNo = sameDwgNo;
    }
}