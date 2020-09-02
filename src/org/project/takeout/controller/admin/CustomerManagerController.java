package org.project.takeout.controller.admin;

import org.project.takeout.biz.ICustomerBiz;
import org.project.takeout.pojo.Customer;
import org.project.takeout.pojo.JsonResult;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller("adminCustomerController")
@RequestMapping("/admin/customer")
public class CustomerManagerController {
    @Resource
    private ICustomerBiz customerBiz;

    @RequestMapping(value = { "/", "/index"})
    public String gotoManagementIndexPage(@RequestParam(value = "page", defaultValue = "1") Integer page,
                                          HttpServletRequest request) {
        List lst = customerBiz.getCustomerByPage(page);
        request.setAttribute("customers", lst);
        request.setAttribute("totalPage", customerBiz.getCustomerTotalPageNum());

        return "admin/customerManager.jsp";
    }

    @RequestMapping(value = "/detail/{id}", method = RequestMethod.GET)
    public String showCustomerDetail(@PathVariable("id") Integer id,
                                     HttpServletRequest request) {
        Customer customer = customerBiz.getCustomerByID(id);
        request.setAttribute("customer", customer);

        return "admin/myself.jsp";
    }

    @RequestMapping(value = "/changeDetail/{id}", method = RequestMethod.GET)
    public String showChangeDetailPage(@PathVariable("id") Integer id,
                                       HttpServletRequest request) {
        Customer customer = customerBiz.getCustomerByID(id);
        request.setAttribute("customer", customer);

        return "admin/editMyself.jsp";
    }

    @RequestMapping("/doChangeDetail")
    @ResponseBody
    public JsonResult doRegister(@RequestParam("id") Integer customerID,
                                 @RequestParam("userName") String userName,
                                 @RequestParam("password") String password,
                                 @RequestParam("nickName") String nickName,
                                 @RequestParam("gender") String gender,
                                 @RequestParam("email") String email) {
        JsonResult result = new JsonResult();

        Customer customer = customerBiz.getCustomerByID(customerID);
        customer.setUserName(userName);
        customer.setPassword(password);
        customer.setNickName(nickName);
        customer.setGender(gender);
        customer.setEmail(email);
        customerBiz.updateCustomer(customer);

        result.setResult(JsonResult.RESULT_TRUE);
        return result;
    }

    @RequestMapping("/delete")
    @ResponseBody
    public JsonResult deleteCustomer(@RequestParam("id") Integer id) {
        JsonResult result = new JsonResult();

        customerBiz.deleteCustomer(id);
        result.setResult(JsonResult.RESULT_TRUE);
        return result;
    }
}
