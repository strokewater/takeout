package org.project.takeout.biz.impl;

import org.project.takeout.biz.IGoodOrderBiz;
import org.project.takeout.dao.IGoodOrderDao;
import org.project.takeout.pojo.GoodOrder;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
import java.util.Set;

@Component("goodOrderBiz")
public class GoodOrderBizImpl implements IGoodOrderBiz {
    @Resource
    private IGoodOrderDao goodOrderDao;

    @Override
    @Transactional
    public void createOrder(int customerID, List<Integer> goodIDs, List<Integer> goodNums, String notice, int recvAddressID) {
        goodOrderDao.createOrder(customerID, goodIDs, goodNums, notice, recvAddressID);
    }

    @Override
    @Transactional
    public Set getAllOrderByCustomer(int customerID) {
        return goodOrderDao.getAllOrderByCustomer(customerID);
    }

    @Override
    @Transactional
    public List getAllOrderByPage(int page) {
        return goodOrderDao.getAllOrderByPage(page);
    }

    @Override
    @Transactional
    public int getGoodOrderTotalPageNum() {
        return goodOrderDao.getGoodOrderTotalPageNum();
    }

    @Override
    @Transactional
    public GoodOrder getOrderByCustomerAndID(int customerID, int orderID) {
        return goodOrderDao.getOrderByCustomerAndID(customerID, orderID);
    }

    @Override
    @Transactional
    public GoodOrder getOrderByID(int orderID) {
        return goodOrderDao.getOrderByID(orderID);
    }

    @Override
    @Transactional
    public void setNextState(int orderID) {
        goodOrderDao.setNextState(orderID);
    }

    @Override
    @Transactional
    public void doCommentByCustomer(int customerID, int orderID, String comment) {
        goodOrderDao.doCommentByCustomer(customerID, orderID, comment);
    }

    @Override
    @Transactional
    public void delete(int orderID) {
        goodOrderDao.delete(orderID);
    }

    @Override
    @Transactional
    public double getThisDayIncome() {
        return goodOrderDao.getThisDayIncome();
    }

    @Override
    @Transactional
    public double getThisMonthIncome() {
        return goodOrderDao.getThisMonthIncome();
    }

    @Override
    @Transactional
    public double getThisYearIncome() {
        return goodOrderDao.getThisYearIncome();
    }
}
