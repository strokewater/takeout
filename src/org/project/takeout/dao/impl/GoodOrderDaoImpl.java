package org.project.takeout.dao.impl;

import org.hibernate.Hibernate;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.project.takeout.dao.IGoodOrderDao;
import org.project.takeout.pojo.*;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.*;

@Component("goodOrderDao")
public class GoodOrderDaoImpl implements IGoodOrderDao {
    @Resource(name = "sessionFactory")
    SessionFactory sessionFactory;

    public static final int NumOfGoodOrderPerPage = 10;

    @Override
    public void createOrder(int customerID, List<Integer> goodIDs, List<Integer> goodNums, String notice, int recvAddressID) {
        Session session = sessionFactory.getCurrentSession();

        double totalPrice = 0.0;

        GoodOrder order = new GoodOrder();
        RecvAddress address = session.get(RecvAddress.class, recvAddressID);

        Customer customer = session.get(Customer.class, customerID);
        order.setCustomer(customer);
        order.setNotice(notice);
        order.setOrderTime(new Date());
        order.setState(GoodOrder.STATE_PREPARE);
        order.setComment(null);
        order.setReceiveAddress(address.getAddress());
        order.setReceiverName(address.getName());
        order.setReceiverPhone(address.getPhone());
        order.setOutStoreTime(null);
        order.setFinishTime(null);
        order.setGoodList(new HashSet<>());

        session.save(order);

        Iterator<Integer> iterGoodID = goodIDs.iterator();
        Iterator<Integer> iterGoodNum = goodNums.iterator();

        while (iterGoodID.hasNext()) {
            Integer goodID = iterGoodID.next();
            Integer goodNum = iterGoodNum.next();

            GoodOrderList item = new GoodOrderList();
            Good goodEmpty = new Good();
            goodEmpty.setId(goodID);

            item.setGood(goodEmpty);
            item.setGoodNum(goodNum);
            item.setOrder(order);
            session.save(item);

            Good good = session.get(Good.class, goodID);
            totalPrice += good.getPrice() * goodNum;
        }

        order.setTotalPrice(totalPrice);
        session.save(order);
    }

    @Override
    public Set getAllOrderByCustomer(int customerID) {
        Session session = sessionFactory.getCurrentSession();

        Customer customer = session.get(Customer.class, customerID);
        Set goodOrders = customer.getGoodOrders();
        Hibernate.initialize(goodOrders);
        return goodOrders;
    }

    @Override
    public List getAllOrderByPage(int page) {
        Session session = sessionFactory.getCurrentSession();

        Query query = session.createQuery("FROM GoodOrder");
        query.setMaxResults(NumOfGoodOrderPerPage);
        query.setFirstResult((page - 1) * NumOfGoodOrderPerPage);

        List list = query.getResultList();
        for (Object i: list) {
            GoodOrder goodOrder = (GoodOrder)i;
            Hibernate.initialize(goodOrder.getCustomer());
            Hibernate.initialize(goodOrder.getGoodList());
        }

        return list;
    }

    public int getGoodOrderTotalPageNum() {
        Session session = sessionFactory.getCurrentSession();

        Query query = session.createQuery("SELECT COUNT(*) FROM GoodOrder ");
        return (int)(((Long)query.getSingleResult() + NumOfGoodOrderPerPage - 1) / NumOfGoodOrderPerPage);
    }

    @Override
    public GoodOrder getOrderByCustomerAndID(int customerID, int orderID) {
        Session session = sessionFactory.getCurrentSession();

        Query query = session.createQuery("FROM GoodOrder WHERE id=?1 AND customer.id=?2");
        query.setParameter(1, orderID);
        query.setParameter(2, customerID);
        GoodOrder order = (GoodOrder)query.getSingleResult();
        if (order == null)
            return null;

        Set goodOrderLists = order.getGoodList();
        for (Object i: goodOrderLists) {
            GoodOrderList item = (GoodOrderList)i;
            Hibernate.initialize(item.getGood());
        }
        return order;
    }

    public GoodOrder getOrderByID(int orderID) {
        Session session = sessionFactory.getCurrentSession();

        GoodOrder order = session.get(GoodOrder.class, orderID);

        Set goodOrderLists = order.getGoodList();
        for (Object i: goodOrderLists) {
            GoodOrderList item = (GoodOrderList)i;
            Hibernate.initialize(item.getGood());
        }
        return order;
    }

    @Override
    public void setNextState(int orderID) {
        Session session = sessionFactory.getCurrentSession();
        GoodOrder order = session.get(GoodOrder.class, orderID);
        if (order.getState() < 2) {
            order.setState(order.getState() + 1);
            session.update(order);
        }
    }

    @Override
    public void doCommentByCustomer(int customerID, int orderID, String comment) {
        Session session = sessionFactory.getCurrentSession();

        GoodOrder order = session.get(GoodOrder.class, orderID);
        if (order.getCustomer().getId() != customerID)
            return;

        order.setComment(comment);
        session.update(order);
    }

    @Override
    public void delete(int orderID) {
        Session session = sessionFactory.getCurrentSession();

        GoodOrder order = session.get(GoodOrder.class, orderID);
        session.delete(order);
    }

    @Override
    public double getThisDayIncome() {
        return getTimezoneIncome("SELECT totalPrice FROM GoodOrder WHERE TO_DAYS(NOW())=TO_DAYS(orderTime)");
    }

    @Override
    public double getThisMonthIncome() {
        return getTimezoneIncome("SELECT totalPrice FROM GoodOrder WHERE DATE_FORMAT(CURDATE(), '%Y%m')=DATE_FORMAT(orderTime,'%Y%m')");
    }

    @Override
    public double getThisYearIncome() {
        return getTimezoneIncome("SELECT totalPrice FROM GoodOrder WHERE YEAR(orderTime)=YEAR(NOW())");
    }

    private double getTimezoneIncome(String HQL) {
        Session session = sessionFactory.getCurrentSession();

        Query query = session.createQuery(HQL);
        List lst = query.getResultList();
        double totalIncome = 0.0;
        for (Object i: lst) {
            totalIncome += (Double)i;
        }

        return totalIncome;
    }
}
