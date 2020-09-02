package org.project.takeout.controller;

import org.project.takeout.TakeOutException;
import org.project.takeout.biz.ICustomerBiz;
import org.project.takeout.pojo.Customer;
import org.project.takeout.pojo.JsonResult;
import org.project.takeout.util.ContextHolderUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller("customerController")
@RequestMapping("/customer")
public class CustomerController {
    @Resource
    private ICustomerBiz customerBiz;

    @RequestMapping("/login")
    public String showLoginPage(HttpSession session, HttpServletRequest request) {
        String redirectUri = (String)session.getAttribute("redirectUri");
        if (redirectUri == null)
        {
            // 如果不是因为被拦截器拦截forward到这的，一律在登陆后转向首页
            session.setAttribute("redirectUri", request.getContextPath() + "/index");
        }

        return "login.jsp";
    }

    @RequestMapping("/register")
    public String showRegisterPage() {
        return "register.jsp";
    }

    @RequestMapping("/doLogin")
    @ResponseBody
    public JsonResult doLogin(@RequestParam("userName") String userName,
                              @RequestParam("password") String password)
    {
        HttpServletRequest request = ContextHolderUtils.getRequest();
        HttpSession session = ContextHolderUtils.getSession();

        Customer customer = new Customer();
        customer.setUserName(userName);
        customer.setPassword(password);
        String redirectUri = (String)session.getAttribute("redirectUri");
        session.removeAttribute("redirectUri");

        return ContextHolderUtils.redirectToPrevPage(customerBiz.login(customer), redirectUri);
    }

    @RequestMapping("/doLogout")
    public String doLogout(Model model)
    {
        boolean isSuccess = true;

        try {
            customerBiz.logout();
        } catch (TakeOutException e)
        {
            model.addAttribute("errorMsg", e.getMessage());
            isSuccess = false;
        }

        if (isSuccess)
            return "redirect:/login";
        else
            return "redirect:/error";
    }

    @RequestMapping("/doRegister")
    @ResponseBody
    public JsonResult doRegister(@RequestParam("userName") String userName,
                                 @RequestParam("password") String password,
                                 @RequestParam("nickName") String nickName,
                                 @RequestParam("gender") String gender,
                                 @RequestParam("email") String email)
    {
        JsonResult result = new JsonResult();

        Customer customer = new Customer();
        customer.setUserName(userName);
        customer.setPassword(password);
        customer.setNickName(nickName);
        customer.setGender(gender);
        customer.setEmail(email);

        if (customerBiz.register(customer))
            result.setResult(JsonResult.RESULT_TRUE);
        else
            result.setResult(JsonResult.RESULT_FALSE);

        return result;
    }

    @RequestMapping("/myself")
    public String showMySelfPage() {
        return "myself.jsp";
    }

    @RequestMapping("/changePassword")
    @ResponseBody
    public JsonResult changePassword(@RequestParam("oldPassword") String oldPassword,
                                     @RequestParam("newPassword") String newPassword) {
        JsonResult result = new JsonResult();

        Customer customer = customerBiz.getCurrentCustomer();
        if (customerBiz.changePassword(customer.getId(), oldPassword, newPassword))
            result.setResult(JsonResult.RESULT_TRUE);
        else
            result.setResult(JsonResult.RESULT_FALSE);

        return result;
    }

    @RequestMapping("/requestLoginJson")
    @ResponseBody
    public JsonResult requestLoginJson() {
        JsonResult result = new JsonResult();
        result.setResult(JsonResult.RESULT_NOT_LOGIN);
        return result;
    }

    public void setCustomerBiz(ICustomerBiz customerBiz) {
        this.customerBiz = customerBiz;
    }
}
