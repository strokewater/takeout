package org.project.takeout.interceptor;

import org.project.takeout.biz.IAdminBiz;
import org.project.takeout.util.ContextHolderUtils;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.lang.reflect.Method;

public class AdminLoginInterceptor implements HandlerInterceptor {
    @Resource
    private IAdminBiz adminBiz;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        if (handler instanceof HandlerMethod) {
            HandlerMethod handlerMethod = (HandlerMethod)handler;
            Method method = handlerMethod.getMethod();
            Class returnType = method.getReturnType();

            String requestURL;
            if (returnType.getName().equals("org.project.takeout.pojo.JsonResult"))
                requestURL = "/admin/requestLoginJson";
            else if (returnType.getName().equals("java.lang.String"))
                requestURL = "/admin/login";
            else
                requestURL = "/error";

            HttpSession session = ContextHolderUtils.getSession();

            if (adminBiz.isLogin())
                return true;
            else {
                session.setAttribute("redirectUri", request.getRequestURI());
                request.getRequestDispatcher(requestURL).forward(request, response);
                return false;
            }
        } else {
            return true;
        }
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}
