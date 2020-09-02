package org.project.takeout.controller.admin;

import org.project.takeout.biz.IGoodOrderBiz;
import org.project.takeout.pojo.GoodOrder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller("GoodOrderManagerController")
@RequestMapping("/admin/order")
public class GoodOrderManagerController {
    @Resource
    private IGoodOrderBiz goodOrderBiz;

    @RequestMapping(value = {"/", "/index"})
    public String showGoodOrderList(@RequestParam(value = "page", defaultValue = "1") Integer page,
                                    HttpServletRequest request) {
        List orders = goodOrderBiz.getAllOrderByPage(page);
        int totalPage = goodOrderBiz.getGoodOrderTotalPageNum();

        request.setAttribute("orders", orders);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("ORDER_STATE", IGoodOrderBiz.ORDER_STATE);
        return "admin/orderManager.jsp";
    }

    @RequestMapping("/nextState")
    public String SetStateToNext(@RequestParam("id") int id) {
        goodOrderBiz.setNextState(id);

        return "redirect:/admin/order/index";
    }

    @RequestMapping("/doDelete")
    public String deleteGoodOrder(@RequestParam("id") int id) {
        goodOrderBiz.delete(id);

        return "redirect:/admin/order/index";
    }

    @RequestMapping("/detail")
    public String showGoodOrderDetail(@RequestParam("id") int id,
                                      HttpServletRequest request) {
        GoodOrder order = goodOrderBiz.getOrderByID(id);

        request.setAttribute("order", order);
        request.setAttribute("ORDER_STATE", IGoodOrderBiz.ORDER_STATE);
        request.setAttribute("ORDER_STATE_LONG_EXPLAIN", IGoodOrderBiz.ORDER_STATE_LONG_EXPLAIN);
        return "admin/orderDetail.jsp";
    }
}
