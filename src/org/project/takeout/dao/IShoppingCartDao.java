package org.project.takeout.dao;

import org.project.takeout.pojo.Customer;
import org.project.takeout.pojo.ShoppingCartItem;

import java.util.Set;

public interface IShoppingCartDao {
    Set getAllItem(int customerID);
    int getNumOfGood(int customerID, int goodID);
    void setNumOfGood(int customerID, int goodID, int newGoodNum);
    void deleteAllItem(int customerID);
}
