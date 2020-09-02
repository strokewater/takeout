package org.project.takeout.dao.impl;

import org.hibernate.Hibernate;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.project.takeout.dao.IGoodDao;
import org.project.takeout.pojo.Category;
import org.project.takeout.pojo.Good;
import org.project.takeout.pojo.GoodOrder;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Component("goodDao")
public class GoodDaoImpl implements IGoodDao {
    @Resource(name = "sessionFactory")
    private SessionFactory sessionFactory;

    public static final int NumOfGoodPerPage = 10;

    @Override
    public List getGoodByCategoryAndPage(int pageNo, int categoryID) {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("FROM Good g WHERE g.category.id=?1");
        query.setParameter(1, categoryID);

        query.setMaxResults(NumOfGoodPerPage);
        query.setFirstResult((pageNo - 1) * NumOfGoodPerPage);

        List lst = query.getResultList();
        Hibernate.initialize(lst);
        Good good = (Good)lst.get(0);
        Hibernate.initialize(good.getCategory());

        return lst;
    }

    @Override
    public List getGoodByPage(int pageNo) {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("FROM Good");

        query.setMaxResults(NumOfGoodPerPage);
        query.setFirstResult((pageNo - 1) * NumOfGoodPerPage);
        List lst = query.getResultList();
        for (Object obj: lst) {
            Good good = (Good)obj;
            Hibernate.initialize(good.getCategory());
        }

        return lst;
    }

    @Override
    public int getGoodTotalPageNum() {
        Session session = sessionFactory.getCurrentSession();

        Query query = session.createQuery("SELECT COUNT(*) FROM Good ");
        return (int)(((Long)query.getSingleResult() + NumOfGoodPerPage - 1) / NumOfGoodPerPage);
    }

    @Override
    public int getGoodInCategoryTotalPageNum(int categoryID) {
        Session session = sessionFactory.getCurrentSession();

        Query query = session.createQuery("SELECT COUNT(*) FROM Good g WHERE g.id=?1");
        query.setParameter(1, categoryID);
        return (int)(((Long)query.getSingleResult() + NumOfGoodPerPage - 1) / NumOfGoodPerPage);
    }

    @Override
    public Good getGoodByID(int goodID) {
        Session session = sessionFactory.getCurrentSession();
        Good result = session.get(Good.class, goodID);
        Hibernate.initialize(result.getCategory());
        return result;
    }

    @Override
    public void add(Good good) {
        Session session = sessionFactory.getCurrentSession();
        session.save(good);
    }

    @Override
    public void update(Good good) {
        Session session = sessionFactory.getCurrentSession();
        Good newGood = session.get(Good.class, good.getId());

        Category newCategory = session.get(Category.class, good.getCategory().getId());

        if (newCategory.getId() != newGood.getId()) {
            newGood.setCategory(newCategory);
            newCategory.getGoods().add(newGood);
            session.update(newGood);
            session.update(newCategory);
        }

        newGood.setDescription(good.getDescription());
        newGood.setName(good.getName());
        newGood.setImgFileName(good.getImgFileName());
        newGood.setPrice(good.getPrice());

        session.update(newGood);
    }

    @Override
    public void delete(int goodID) {
        Session session = sessionFactory.getCurrentSession();

        Good good = session.get(Good.class, goodID);
        session.delete(good);
    }
}
