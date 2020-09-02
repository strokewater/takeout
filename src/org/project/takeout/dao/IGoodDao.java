package org.project.takeout.dao;

import org.project.takeout.pojo.Category;
import org.project.takeout.pojo.Good;

import java.util.List;
import java.util.Set;

public interface IGoodDao {
    List getGoodByCategoryAndPage(int pageNo, int categoryID);
    List getGoodByPage(int pageNo);
    int getGoodTotalPageNum();
    int getGoodInCategoryTotalPageNum(int categoryID);
    Good getGoodByID(int goodID);

    void delete(int goodID);
    void update(Good good);
    void add(Good good);
}
