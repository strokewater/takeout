package org.project.takeout.controller;

import org.project.takeout.biz.ICustomerBiz;
import org.project.takeout.biz.IGoodOrderBiz;
import org.project.takeout.biz.IShoppingCartBiz;
import org.project.takeout.pojo.Customer;
import org.project.takeout.pojo.GoodOrder;
import org.project.takeout.pojo.JsonResult;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Set;

@Controller("goodOrderController")
@RequestMapping("/order")
public class GoodOrderController {
    @Resource
    private ICustomerBiz customerBiz;

    @Resource(name = "goodOrderBiz")
    private IGoodOrderBiz goodOrderBiz;

    @Resource
    private IShoppingCartBiz shoppingCartBiz;

    @RequestMapping("/create")
    @ResponseBody
    public JsonResult createOrder(@RequestParam("goodIDs") String[] goodIDs,
                                  @RequestParam("goodNums") String[] goodNums,
                                  @RequestParam(value = "notice", defaultValue = "") String notice,
                                  @RequestParam("addressID") int addressID) {
        JsonResult result = new JsonResult();
        Customer customer = customerBiz.getCurrentCustomer();

        if (goodIDs.length != goodNums.length)
        {
            result.setResult(JsonResult.RESULT_FALSE);
            return result;
        }

        ArrayList<Integer> goodIDList = new ArrayList<>();
        ArrayList<Integer> goodNumList = new ArrayList<>();

        for (int i = 0; i < goodIDs.length; ++i) {
            goodIDList.add(Integer.parseInt(goodIDs[i]));
            goodNumList.add(Integer.parseInt(goodNums[i]));
        }

        goodOrderBiz.createOrder(customer.getId(), goodIDList, goodNumList, notice, addressID);
        shoppingCartBiz.removeGoods(customer.getId(), goodIDList);

        result.setResult(JsonResult.RESULT_TRUE);
        return result;
    }

    @RequestMapping("/index")
    public String showGoodOrder(HttpServletRequest request)
    {
        Customer customer = customerBiz.getCurrentCustomer();

        Set lst = goodOrderBiz.getAllOrderByCustomer(customer.getId());
        request.setAttribute("orderList", lst);
        return "order.jsp";
    }

    @RequestMapping(value = "/detail/{id}", method = RequestMethod.GET)
    public String showGoodOrderDetail(@PathVariable("id") int id,
                                      HttpServletRequest request) {
        Customer customer = customerBiz.getCurrentCustomer();

        GoodOrder order = goodOrderBiz.getOrderByCustomerAndID(customer.getId(), id);
        request.setAttribute("order", order);
        return "order_detail.jsp";
    }

    @RequestMapping("/comment")
    @ResponseBody
    public JsonResult commentOnGoodOrder(@RequestParam("id") int id,
                                         @RequestParam("comment") String comment) {
        JsonResult result = new JsonResult();
        Customer customer = customerBiz.getCurrentCustomer();

        goodOrderBiz.doCommentByCustomer(customer.getId(), id, comment);
        result.setResult(JsonResult.RESULT_TRUE);
        return result;
    }
}
