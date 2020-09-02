package org.project.takeout.biz;

import java.util.List;
import java.util.Set;

public interface IShoppingCartBiz {
    Set getAllItem(int customerID);
    void chanegNumOfGoodByVariation(int customerID, int goodID, int variation);
    void setNumOfGood(int customerID, int goodID, int goodNum);
    void removeGoods(int customerID, List<Integer> goodIDs);
    void deleteAllItem(int customerID);
}
