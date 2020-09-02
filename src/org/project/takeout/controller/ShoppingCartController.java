package org.project.takeout.controller;

import org.project.takeout.biz.ICustomerBiz;
import org.project.takeout.biz.IShoppingCartBiz;
import org.project.takeout.pojo.Customer;
import org.project.takeout.pojo.JsonResult;
import org.project.takeout.util.ContextHolderUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

@Controller("shoppingCartController")
@RequestMapping("/shoppingCart")
public class ShoppingCartController  {
    @Resource(name = "shoppingCartBiz")
    private IShoppingCartBiz shoppingCartBiz;

    @Resource(name = "customerBiz")
    private ICustomerBiz customerBiz;

    @RequestMapping("/changeNum")
    @ResponseBody
    public JsonResult chanegNumOfGood(@RequestParam("goodID") int goodID,
                                      @RequestParam("goodNumVariation") int goodNumVariation)
    {
        JsonResult result = new JsonResult();

        Customer customer = customerBiz.getCurrentCustomer();
        if (customer == null) {
            result.setResult(JsonResult.RESULT_NOT_LOGIN);
            return result;
        }
        shoppingCartBiz.chanegNumOfGoodByVariation(customer.getId(), goodID, goodNumVariation);

        result.setResult(JsonResult.RESULT_TRUE);

        return result;
    }

    @RequestMapping("/setNum")
    @ResponseBody
    public JsonResult setNumOfGood(@RequestParam("goodID") int goodID,
                                   @RequestParam("goodNum") int goodNum)
    {
        JsonResult result = new JsonResult();

        Customer customer = customerBiz.getCurrentCustomer();
        if (customer == null) {
            result.setResult(JsonResult.RESULT_NOT_LOGIN);
            return result;
        }
        shoppingCartBiz.setNumOfGood(customer.getId(), goodID, goodNum);

        result.setResult(JsonResult.RESULT_TRUE);

        return result;
    }

    @RequestMapping("/removeGoodList")
    @ResponseBody
    public JsonResult removeList(@RequestParam("goodIDs") String[] goodIDs)
    {
        JsonResult result = new JsonResult();

        Customer customer = customerBiz.getCurrentCustomer();
        if (customer == null) {
            result.setResult(JsonResult.RESULT_NOT_LOGIN);
            return result;
        }

        List<Integer> allGoodID = new ArrayList<>();

        for (String i: goodIDs)
            allGoodID.add(Integer.parseInt(i));

        shoppingCartBiz.removeGoods(customer.getId(), allGoodID);

        result.setResult(JsonResult.RESULT_TRUE);
        return result;
    }

    @RequestMapping("/index")
    public String showShoppingCart(HttpServletRequest request)
    {
        Customer customer = customerBiz.getCurrentCustomer();
        if (customer == null)
            return "redirect:login";
        Set lst = shoppingCartBiz.getAllItem(customer.getId());
        request.setAttribute("shoppingCartList", lst);
        return "shoppingCart.jsp";
    }
}
