package org.project.takeout.controller;

import org.project.takeout.biz.ICategoryBiz;
import org.project.takeout.biz.ICustomerBiz;
import org.project.takeout.biz.IGoodBiz;
import org.project.takeout.dao.ICategoryDao;
import org.project.takeout.pojo.Good;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller("goodController")
@RequestMapping("/good")
public class GoodController {
    @Resource(name = "goodBiz")
    IGoodBiz goodBiz;

    @Resource
    ICategoryBiz categoryBiz;

    @Resource(name = "customerBiz")
    ICustomerBiz customerBiz;

    @RequestMapping("/index")
    public String goodList(@RequestParam(value = "categoryID", defaultValue = "0") Integer categoryID,
                           @RequestParam(value = "pageNo", defaultValue = "1") Integer pageNo,
                           HttpServletRequest request) {
        List goods;
        int goodTotalPageNum;

        if (categoryID == 0) {
            goods = goodBiz.getGoodByPage(pageNo);
            goodTotalPageNum = goodBiz.getGoodTotalPageNum();
        } else {
            goods = goodBiz.getGoodByCategoryAndPage(pageNo, categoryID);
            goodTotalPageNum = goodBiz.getGoodInCategoryTotalPageNum(categoryID);
        }

        List categories = categoryBiz.getAllCategory();

        request.setAttribute("goods", goods);
        request.setAttribute("categories", categories);
        request.setAttribute("goodTotalPageNum", goodTotalPageNum);
        return "main.jsp";
    }

    @RequestMapping(value = "/detail/{id}", method = RequestMethod.GET)
    public String showGoodDetail(@PathVariable("id") int id,
                                      HttpServletRequest request) {
        Good good = goodBiz.getGoodByID(id);
        request.setAttribute("good", good);
        return "good_detail.jsp";
    }
}
