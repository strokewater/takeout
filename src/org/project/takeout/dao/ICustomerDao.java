package org.project.takeout.dao;

import org.project.takeout.pojo.Customer;

import java.util.List;

public interface ICustomerDao {
    boolean checkUserNameAndPassword(Customer customer);
    boolean insertNewUser(Customer customer);
    Customer getCustomerByUserName(String userName);
    boolean changePassword(int customerID, String oldPassword, String newPassword);
    List getCustomerByPage(int pageNo);
    int getCustomerTotalPageNum();
    Customer getCustomerByID(int customerID);
    void updateCustomer(Customer customer);
    void deleteCustomer(int customerID);
}
