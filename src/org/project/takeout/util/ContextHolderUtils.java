package org.project.takeout.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.project.takeout.pojo.JsonResult;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

public class ContextHolderUtils {
    /**
     * SpringMvc下获取request
     *
     * @return
     */
    public static HttpServletRequest getRequest() {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        return request;

    }
    /**
     * SpringMvc下获取session
     *
     * @return
     */
    public static HttpSession getSession() {
        HttpSession session = getRequest().getSession();
        return session;
    }

    public static JsonResult redirectToPrevPage(boolean isRedirect, String redirectURI) {
        JsonResult result = new JsonResult();
        HttpSession session = ContextHolderUtils.getSession();

        if (isRedirect) {
            result.setResult(JsonResult.RESULT_TRUE);
            result.setRedirectURL(redirectURI);
        } else {
            result.setResult(JsonResult.RESULT_FALSE);
            result.setRedirectURL("");
        }

        return result;
    }
}