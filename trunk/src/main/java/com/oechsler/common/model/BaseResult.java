package com.oechsler.common.model;

/**
 * author:kriswang
 * date:2017/11/20 0020下午 13:42
 **/
public class BaseResult {

    private Boolean result;

    private String message;

    private String url;

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Boolean getResult() {
        return result;
    }

    public void setResult(Boolean result) {
        this.result = result;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
