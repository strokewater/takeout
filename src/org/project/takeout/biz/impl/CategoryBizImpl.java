package org.project.takeout.biz.impl;

import org.project.takeout.biz.ICategoryBiz;
import org.project.takeout.dao.ICategoryDao;
import org.project.takeout.pojo.Category;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Component("categoryBiz")
@Transactional(propagation = Propagation.REQUIRED)
public class CategoryBizImpl implements ICategoryBiz {
    @Resource
    private ICategoryDao categoryDao;

    @Override
    public List getAllCategory() {
        return categoryDao.getAllCategory();
    }

    @Override
    public void add(Category category) {
        categoryDao.add(category);
    }

    @Override
    public void edit(Category category) {
        categoryDao.edit(category);
    }

    @Override
    public void delete(int id) {
        categoryDao.delete(id);
    }
}
