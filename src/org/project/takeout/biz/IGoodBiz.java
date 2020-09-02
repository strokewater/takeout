package org.project.takeout.biz;

import org.project.takeout.pojo.Category;
import org.project.takeout.pojo.Good;

import java.util.List;

public interface IGoodBiz {
    List getGoodByCategoryAndPage(int pageNo, int categoryID);
    List getGoodByPage(int pageNo);
    int getGoodTotalPageNum();
    int getGoodInCategoryTotalPageNum(int categoryID);
    Good getGoodByID(int goodID);

    void delete(int goodID);
    void update(Good good);
    void add(Good good);
}
