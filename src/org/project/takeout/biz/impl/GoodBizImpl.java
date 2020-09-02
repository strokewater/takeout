package org.project.takeout.biz.impl;

import org.hibernate.Transaction;
import org.project.takeout.biz.IGoodBiz;
import org.project.takeout.dao.IGoodDao;
import org.project.takeout.pojo.Category;
import org.project.takeout.pojo.Good;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Component("goodBiz")
@Transactional(propagation = Propagation.REQUIRED)
public class GoodBizImpl implements IGoodBiz {
    @Resource(name = "goodDao")
    IGoodDao goodDao;

    @Override
    public List getGoodByCategoryAndPage(int pageNo, int categoryID) {
        return goodDao.getGoodByCategoryAndPage(pageNo, categoryID);
    }

    @Override
    public List getGoodByPage(int pageNo) {
        return goodDao.getGoodByPage(pageNo);
    }


    @Override
    public int getGoodTotalPageNum() {
        return goodDao.getGoodTotalPageNum();
    }

    @Override
    public int getGoodInCategoryTotalPageNum(int categoryID) {
        return goodDao.getGoodInCategoryTotalPageNum(categoryID);
    }

    @Override
    public Good getGoodByID(int goodID) {
        return goodDao.getGoodByID(goodID);
    }

    @Override
    public void add(Good good) {
        goodDao.add(good);
    }

    @Override
    public void update(Good good) {
        goodDao.update(good);
    }

    @Override
    public void delete(int goodID) {
        goodDao.delete(goodID);
    }
}
