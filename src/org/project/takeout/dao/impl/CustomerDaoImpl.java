package org.project.takeout.dao.impl;

import org.hibernate.Hibernate;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.project.takeout.dao.ICustomerDao;
import org.project.takeout.pojo.Customer;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.List;
import java.util.Set;

@Component("customerDao")
public class CustomerDaoImpl implements ICustomerDao {
    public static final int NumOfCustomerPerPage = 10;

    @Resource(name = "sessionFactory")
    private SessionFactory sessionFactory;
    private Session session;

    @Override
    public boolean checkUserNameAndPassword(Customer customer) {
        session = sessionFactory.getCurrentSession();

        Query query = session.createQuery("FROM Customer AS c WHERE c.userName = ?1 AND c.password = ?2");
        query.setParameter(1, customer.getUserName());
        query.setParameter(2, customer.getPassword());
        List lst = query.getResultList();

        return lst.size() != 0;
    }

    @Override
    public boolean insertNewUser(Customer customer) {
        session = sessionFactory.getCurrentSession();

        session.save(customer);
        return true;
    }

    @Override
    public Customer getCustomerByUserName(String userName) {
        session = sessionFactory.getCurrentSession();

        Query query = session.createQuery("FROM Customer WHERE userName = ?1");
        query.setParameter(1, userName);
        return (Customer)query.getSingleResult();
    }

    @Override
    public boolean changePassword(int customerID, String oldPassword, String newPassword) {
        session = sessionFactory.getCurrentSession();

        Customer customer = session.get(Customer.class, customerID);
        if (customer == null)
            return false;

        if (!customer.getPassword().equals(oldPassword))
            return false;

        customer.setPassword(newPassword);
        session.update(customer);

        return true;
    }

    public List getCustomerByPage(int pageNo) {
        Session session = sessionFactory.getCurrentSession();

        Query query = session.createQuery("FROM Customer");
        query.setMaxResults(NumOfCustomerPerPage);
        query.setFirstResult((pageNo - 1) * NumOfCustomerPerPage);
        List lst = query.getResultList();
        Hibernate.initialize(lst);
        return lst;
    }

    @Override
    public int getCustomerTotalPageNum() {
        Session session = sessionFactory.getCurrentSession();

        Query query = session.createQuery("SELECT  COUNT(*) FROm Customer ");
        Long num = (Long)query.getSingleResult();
        return (int)((num + NumOfCustomerPerPage - 1) / NumOfCustomerPerPage);
    }

    @Override
    public Customer getCustomerByID(int customerID) {
        Session session = sessionFactory.getCurrentSession();

        Customer customer = session.load(Customer.class, customerID);
        Hibernate.initialize(customer);
        return  customer;
    }

    @Override
    public void updateCustomer(Customer customer) {
        Session session = sessionFactory.getCurrentSession();

        session.update(customer);
    }

    @Override
    public void deleteCustomer(int customerID) {
        Session session = sessionFactory.getCurrentSession();

        Customer customer = session.get(Customer.class, customerID);
        session.delete(customer);
    }

    public void setSession(Session session) {
        this.session = session;
    }
}
