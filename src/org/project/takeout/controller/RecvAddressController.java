package org.project.takeout.controller;

import org.project.takeout.biz.ICustomerBiz;
import org.project.takeout.biz.IRecvAddressBiz;
import org.project.takeout.pojo.Customer;
import org.project.takeout.pojo.JsonResult;
import org.project.takeout.pojo.RecvAddress;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Set;

@Controller
@RequestMapping("/address")
public class RecvAddressController {
    @Resource(name = "customerBiz")
    private ICustomerBiz customerBiz;

    @Resource(name = "recvAddressBiz")
    private IRecvAddressBiz recvAddressBiz;

    @RequestMapping("/index")
    public String showRecvAddress(HttpServletRequest request)
    {
        Customer customer = customerBiz.getCurrentCustomer();

        Set lst = recvAddressBiz.getAllItems(customer.getId());
        request.setAttribute("addressList", lst);
        return "address.jsp";
    }

    @RequestMapping("/frameIndex")
    public String showRecvAddressAsFrame(HttpServletRequest request)
    {
        Customer customer = customerBiz.getCurrentCustomer();

        Set lst = recvAddressBiz.getAllItems(customer.getId());
        request.setAttribute("addressList", lst);
        return "address_frame.jsp";
    }

    @RequestMapping("/add")
    @ResponseBody
    public JsonResult addAddress(@RequestParam("name") String name,
                                 @RequestParam("address") String address,
                                 @RequestParam("phone") String phone) {

        JsonResult result = new JsonResult();

        Customer customer = customerBiz.getCurrentCustomer();

        RecvAddress recvAddress = new RecvAddress();
        recvAddress.setAddress(address);
        recvAddress.setName(name);
        recvAddress.setPhone(phone);

        recvAddressBiz.add(customer.getId(), recvAddress);

        result.setResult(JsonResult.RESULT_TRUE);
        return result;
    }

    @RequestMapping("/edit")
    @ResponseBody
    public JsonResult editAddress(@RequestParam("id") int  ID,
                                 @RequestParam("name") String name,
                                 @RequestParam("address") String address,
                                 @RequestParam("phone") String phone) {

        JsonResult result = new JsonResult();

        Customer customer = customerBiz.getCurrentCustomer();

        RecvAddress recvAddress = getRecvAddressInst(name, address, phone);
        recvAddress.setId(ID);
        recvAddressBiz.edit(customer.getId(), recvAddress);

        result.setResult(JsonResult.RESULT_TRUE);
        return result;
    }

    @RequestMapping("/delete")
    @ResponseBody
    public JsonResult deleteAddress(@RequestParam("id") int ID) {

        JsonResult result = new JsonResult();

        Customer customer = customerBiz.getCurrentCustomer();

        recvAddressBiz.delete(customer.getId(), ID);

        result.setResult(JsonResult.RESULT_TRUE);
        return result;
    }


    private RecvAddress getRecvAddressInst(String name, String address, String phone)
    {
        RecvAddress recvAddress = new RecvAddress();
        recvAddress.setAddress(address);
        recvAddress.setName(name);
        recvAddress.setPhone(phone);

        return recvAddress;
    }
}

