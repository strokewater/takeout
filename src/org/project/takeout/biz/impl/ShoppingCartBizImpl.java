package org.project.takeout.biz.impl;

import org.project.takeout.biz.IShoppingCartBiz;
import org.project.takeout.dao.IGoodDao;
import org.project.takeout.dao.IShoppingCartDao;
import org.project.takeout.pojo.Customer;
import org.project.takeout.pojo.Good;
import org.project.takeout.pojo.ShoppingCartItem;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
import java.util.Set;

@Component("shoppingCartBiz")
public class ShoppingCartBizImpl implements IShoppingCartBiz {
    @Resource(name = "shoppingCartDao")
    private IShoppingCartDao shoppingCartDao;

    @Resource(name = "goodDao")
    private IGoodDao goodDao;

    @Override
    @Transactional
    public Set getAllItem(int customerID) {
        return shoppingCartDao.getAllItem(customerID);
    }

    @Override
    @Transactional
    public void chanegNumOfGoodByVariation(int customerID, int goodID, int variation) {
        int numOfGood = shoppingCartDao.getNumOfGood(customerID, goodID);
        shoppingCartDao.setNumOfGood(customerID, goodID, numOfGood + variation);
    }

    @Transactional
    public void setNumOfGood(int customerID, int goodID, int goodNum) {
        shoppingCartDao.setNumOfGood(customerID, goodID, goodNum);
    }

    @Override
    @Transactional
    public void removeGoods(int customerID, List<Integer> goodIDs) {
        for (Integer i: goodIDs) {
            setNumOfGood(customerID, i, 0);
        }
    }

    @Override
    @Transactional
    public void deleteAllItem(int customerID) {
        shoppingCartDao.deleteAllItem(customerID);
    }
}
