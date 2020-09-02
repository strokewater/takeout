package org.project.takeout.biz;

import org.project.takeout.pojo.GoodOrder;

import java.util.List;
import java.util.Set;

public interface IGoodOrderBiz {
    String ORDER_STATE[] = {
            "制作中",
            "配送中",
            "已送达"
    };

    String ORDER_STATE_LONG_EXPLAIN[] = {
            "我们已收到您的订单，正在制作.",
            "正在派送中.",
            "食品已送达."
    };

    void createOrder(int customerID, List<Integer> goodIDs, List<Integer> goodNums, String notice, int recvAddressID);
    Set getAllOrderByCustomer(int customerID);
    List getAllOrderByPage(int page);
    int getGoodOrderTotalPageNum();
    GoodOrder getOrderByCustomerAndID(int customerID, int orderID);
    GoodOrder getOrderByID(int orderID);
    void doCommentByCustomer(int customerID, int orderID, String comment);
    void setNextState(int orderID);

    void delete(int orderID);

    double getThisDayIncome();
    double getThisMonthIncome();
    double getThisYearIncome();
}
