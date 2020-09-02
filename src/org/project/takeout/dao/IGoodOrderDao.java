package org.project.takeout.dao;

import org.project.takeout.TakeOutException;
import org.project.takeout.pojo.Good;
import org.project.takeout.pojo.GoodOrder;

import java.util.List;
import java.util.Set;

public interface IGoodOrderDao {
    void createOrder(int customerID, List<Integer> goodIDs, List<Integer> goodNums, String notice, int recvAddressID);
    Set getAllOrderByCustomer(int customerID);
    List getAllOrderByPage(int page);
    int getGoodOrderTotalPageNum();
    GoodOrder getOrderByCustomerAndID(int customerID, int orderID);
    GoodOrder getOrderByID(int orderID);;
    void doCommentByCustomer(int customerID, int orderID, String comment);
    void setNextState(int orderID);

    void delete(int orderID);


    double getThisDayIncome();
    double getThisMonthIncome();
    double getThisYearIncome();
}
