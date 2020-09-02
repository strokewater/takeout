package org.project.takeout.dao.impl;

import org.hibernate.Hibernate;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.project.takeout.dao.IGoodDao;
import org.project.takeout.dao.IShoppingCartDao;
import org.project.takeout.pojo.Customer;
import org.project.takeout.pojo.Good;
import org.project.takeout.pojo.ShoppingCartItem;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import javax.persistence.Query;
import java.util.Set;

@Component("shoppingCartDao")
public class ShoppingCartDaoImpl implements IShoppingCartDao {
    @Resource(name = "sessionFactory")
    private SessionFactory sessionFactory;

    @Resource(name = "goodDao")
    private IGoodDao goodDao;

    @Override
    public Set getAllItem(int customerID) {
        Session session = sessionFactory.getCurrentSession();

        Customer customer = session.get(Customer.class, customerID);
        Set sets = customer.getShoppingCartItems();
        for (Object obj: sets) {
            Hibernate.initialize(((ShoppingCartItem)obj).getGood());
        }
        return sets;
    }

    @Override
    public int getNumOfGood(int customerID, int goodID) {
        Session session = sessionFactory.getCurrentSession();

        Customer customer = session.get(Customer.class, customerID);
        Set items = customer.getShoppingCartItems();
        for (Object i: items) {
            ShoppingCartItem item = (ShoppingCartItem)i;
            if (item.getGood().getId() == goodID)
                return item.getGoodNum();
        }

        return 0;
    }

    @Override
    public void setNumOfGood(int customerID, int goodID, int newGoodNum) {
        Session session = sessionFactory.getCurrentSession();
        Customer customer = session.get(Customer.class, customerID);

        Set<ShoppingCartItem> items = customer.getShoppingCartItems();
        ShoppingCartItem item;
        for (Object i: items) {
            item = (ShoppingCartItem)i;
            if (item.getGood().getId() == goodID) {
                if (newGoodNum > 0) {
                    item.setGoodNum(newGoodNum);
                    session.update(item);
                } else
                    session.delete(item);

                return;
            }
        }

        item = new ShoppingCartItem();
        Good goodOnlyID = new Good();

        goodOnlyID.setId(goodID);

        item.setCustomer(customer);
        item.setGood(goodOnlyID);
        item.setGoodNum(newGoodNum);
        session.save(item);
    }

    @Override
    public void deleteAllItem(int customerID) {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("DELETE FROM ShoppingCartItem WHERE customer.id = ?1");
        query.setParameter(1, customerID);
        query.executeUpdate();
    }
}
