package org.project.takeout.dao.impl;

import org.hibernate.Hibernate;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.project.takeout.dao.IRecvAddressDao;
import org.project.takeout.pojo.Customer;
import org.project.takeout.pojo.RecvAddress;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.Set;

@Component("recvAddressDao")
public class RecvAddressDaoImpl implements IRecvAddressDao {
    @Resource(name = "sessionFactory")
    SessionFactory sessionFactory;

    @Override
    public void add(int customerID, RecvAddress address) {
        Session session = sessionFactory.getCurrentSession();

        RecvAddress addr = new RecvAddress();
        addr.setAddress(address.getAddress());
        addr.setPhone(address.getPhone());
        addr.setName(address.getName());
        addr.setCustomer(session.get(Customer.class, customerID));

        session.save(addr);
    }

    @Override
    public void edit(int customerID, RecvAddress address) {
        Session session = sessionFactory.getCurrentSession();

        RecvAddress originAddress = session.get(RecvAddress.class, address.getId());
        originAddress.setName(address.getName());
        originAddress.setAddress(address.getAddress());
        originAddress.setPhone(address.getPhone());

        session.update(originAddress);
    }

    @Override
    public void delete(int customerID, int recvAddressID) {
        Session session = sessionFactory.getCurrentSession();

        RecvAddress addr = new RecvAddress();
        addr.setId(recvAddressID);
        session.delete(addr);
    }

    @Override
    public Set getAllItems(int customerID) {
        Session session = sessionFactory.getCurrentSession();

        Customer customer = session.get(Customer.class, customerID);
        Set sets = customer.getRecvAddresses();
        Hibernate.initialize(sets);

        return sets;
    }
}
