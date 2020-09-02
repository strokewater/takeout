package org.project.takeout.biz;

import org.project.takeout.TakeOutException;
import org.project.takeout.pojo.Customer;

import java.util.List;

public interface ICustomerBiz {
    public static int SUB_CODE_NOT_LOGIN = 0;

    boolean login(Customer customer);
    boolean register(Customer customer);
    void logout() throws TakeOutException;
    boolean isLogin();
    Customer getCurrentCustomer();
    boolean changePassword(int customerID, String oldPassword, String newPassword);
    List getCustomerByPage(int pageNo);
    int getCustomerTotalPageNum();
    Customer getCustomerByID(int customerID);
    void updateCustomer(Customer customer);
    void deleteCustomer(int customerID);
}
