package com.oechsler.common.page;

import java.io.Serializable;
import java.util.List;

/**
 * 分页数据结果集
 */
public class PageResult<T> implements Serializable {
    private static final long serialVersionUID = 1L;

    // 当前页数据
    private List<T> data;
    // 页码
    private Integer pageIndex;
    // 每页显示数量
    private Integer pageSize;
    // 总行数
    private Integer totalRows;
    // 总页数
    private Integer totalPages;

    public PageResult(List<T> data, Integer pageIndex, Integer pageSize, Integer totalRows) {
        this.data = data;
        this.pageIndex = pageIndex;
        this.pageSize = pageSize;
        this.totalRows = totalRows;
        // 计算总页数
        if (this.totalRows == null || this.totalRows == 0) {
            totalPages = 1;
        } else {
            totalPages = totalRows % pageSize == 0 ? totalRows / pageSize : totalRows / pageSize + 1;
        }
    }

    public List<T> getData() {
        return data;
    }

    public Integer getPageIndex() {
        return pageIndex;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public Integer getTotalRows() {
        return totalRows;
    }

    public Integer getTotalPages() {
        return totalPages;
    }

    @Override
    public String toString() {
        return "PageResult [data=" + data + ", pageIndex=" + pageIndex + ", pageSize=" + pageSize + ", totalRows="
                + totalRows + ", totalPages=" + totalPages + "]";
    }
}