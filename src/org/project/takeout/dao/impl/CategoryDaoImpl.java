package org.project.takeout.dao.impl;

import org.hibernate.Hibernate;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.project.takeout.dao.ICategoryDao;
import org.project.takeout.pojo.Category;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.List;

@Component("categoryDao")
public class CategoryDaoImpl implements ICategoryDao {
    @Resource
    private SessionFactory sessionFactory;

    @Override
    public List getAllCategory() {
        Session session = sessionFactory.getCurrentSession();

        Query query = session.createQuery("FROM Category");
        List lst = query.getResultList();
        Hibernate.initialize(lst);
        return lst;
    }

    @Override
    public void add(Category category) {
        Session session = sessionFactory.getCurrentSession();

        session.save(category);
    }

    @Override
    public void edit(Category category) {
        Session session = sessionFactory.getCurrentSession();

        Category category1 = session.get(Category.class, category.getId());
        category1.setName(category.getName());
        session.update(category1);
    }

    @Override
    public void delete(int id) {
        Session session = sessionFactory.getCurrentSession();

        Category category = session.get(Category.class, id);
        session.delete(category);
    }
}
