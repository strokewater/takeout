package org.project.takeout.controller;

import org.project.takeout.pojo.JsonResult;
import org.project.takeout.util.ContextHolderUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller("pageController")
public class PageController {

    @RequestMapping(value = {"/", "/index"})
    public String gotoCustomerIndex()
    {
        return "forward:good/index";
    }

    @RequestMapping("/login")
    public String gotoLoginPage(HttpSession session, HttpServletRequest request)
    {
        return "forward:customer/login";
    }

    @RequestMapping("/register")
    public String gotoRegisterPage() {
        return "forward:customer/register";
    }

    @RequestMapping("/shoppingCart")
    public String gotoShoppingCartPage()
    {
        return "forward:shoppingCart/index";
    }

    @RequestMapping("/address")
    public String gotoRecvAddressPage() { return "forward:address/index"; }

    @RequestMapping("/order")
    public String gotoOrderPage() {return "forward:order/index";}

    @RequestMapping("/myself")
    public String gotoMySelfPage() { return "forward:customer/myself"; }

    @RequestMapping("/error")
    public String gotoErrorPage() {
        return "error.jsp";
    }

    @RequestMapping("/admin")
    public String gotoAdminIndexPage() { return "redirect:admin/index"; }
}
