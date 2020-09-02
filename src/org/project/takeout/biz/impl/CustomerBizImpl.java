package org.project.takeout.biz.impl;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.project.takeout.TakeOutException;
import org.project.takeout.TakeOutExceptionClassCode;
import org.project.takeout.biz.ICustomerBiz;
import org.project.takeout.dao.ICustomerDao;
import org.project.takeout.pojo.Customer;
import org.project.takeout.util.ContextHolderUtils;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Component("customerBiz")
@Transactional(propagation = Propagation.REQUIRED)
public class CustomerBizImpl implements ICustomerBiz {
    @Resource(name = "customerDao")
    private ICustomerDao customerDao;

    static {
        TakeOutException.setException(TakeOutExceptionClassCode.CUSTOMER_BIZ, ICustomerBiz.SUB_CODE_NOT_LOGIN, "Not login");
    }

    @Override
    public boolean login(Customer customer) {
        HttpSession session = ContextHolderUtils.getSession();

        if (customerDao.checkUserNameAndPassword(customer))
        {
            Customer customer1 = customerDao.getCustomerByUserName(customer.getUserName());
            session.setAttribute("customer", customer1);
            return true;
        } else
            return false;
    }

    @Override
    public void logout() throws TakeOutException {
        HttpSession session = ContextHolderUtils.getSession();

        if (session.getAttribute("customer") != null)
            session.removeAttribute("customer");
        else
            throw new TakeOutException(TakeOutExceptionClassCode.CUSTOMER_BIZ, ICustomerBiz.SUB_CODE_NOT_LOGIN);
    }

    @Override
    public boolean register(Customer customer) {
        HttpSession session = ContextHolderUtils.getSession();

        return customerDao.insertNewUser(customer);
    }

    @Override
    public boolean isLogin() {
        HttpSession session = ContextHolderUtils.getSession();

        return session.getAttribute("customer") != null;
    }

    @Override
    public Customer getCurrentCustomer() {
        HttpSession session = ContextHolderUtils.getSession();

        return (Customer)session.getAttribute("customer");
    }

    @Override
    public boolean changePassword(int customerID, String oldPassword, String newPassword) {
        return customerDao.changePassword(customerID, oldPassword, newPassword);
    }

    @Override
    public List getCustomerByPage(int pageNo) {
        return customerDao.getCustomerByPage(pageNo);
    }

    @Override
    public int getCustomerTotalPageNum() {
        return customerDao.getCustomerTotalPageNum();
    }

    @Override
    public Customer getCustomerByID(int customerID) {
        return customerDao.getCustomerByID(customerID);
    }

    @Override
    public void updateCustomer(Customer customer) {
        customerDao.updateCustomer(customer);
    }

    @Override
    public void deleteCustomer(int customerID) {
        customerDao.deleteCustomer(customerID);
    }

    public void setCustomerDAO(ICustomerDao customerDAO) {
        this.customerDao = customerDAO;
    }
}
