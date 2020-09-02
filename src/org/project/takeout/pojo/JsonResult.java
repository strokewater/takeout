package org.project.takeout.pojo;

public class JsonResult {
    public static final String RESULT_TRUE = "true";
    public static final String RESULT_FALSE = "false";
    public static final String RESULT_NOT_LOGIN = "not_login";

    private String result;
    private String redirectURL = "";

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public String getRedirectURL() {
        return redirectURL;
    }

    public void setRedirectURL(String redirectURL) {
        this.redirectURL = redirectURL;
    }
}
