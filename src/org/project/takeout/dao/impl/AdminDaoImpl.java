package org.project.takeout.dao.impl;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.project.takeout.dao.IAdminDao;
import org.project.takeout.pojo.Admin;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;

import javax.annotation.Resource;
import java.util.List;

@Component("adminDao")
public class AdminDaoImpl implements IAdminDao {
    @Resource(name = "sessionFactory")
    private SessionFactory sessionFactory;
    private Session session;

    @Override
    public boolean checkUserNameAndPassword(Admin admin) {
        session = sessionFactory.getCurrentSession();

        Query query = session.createQuery("FROM Admin AS c WHERE c.userName = ?1 AND c.password = ?2");
        query.setParameter(1, admin.getUserName());
        query.setParameter(2, admin.getPassword());
        List lst = query.getResultList();

        return lst.size() != 0;
    }

    @Override
    public boolean changePassword(int adminID, String oldPassword, String newPassword) {
        session = sessionFactory.getCurrentSession();

        Admin admin = session.get(Admin.class, adminID);
        if (admin == null)
            return false;

        if (!admin.getPassword().equals(oldPassword))
            return false;

        admin.setPassword(newPassword);
        session.update(admin);

        return true;
    }

    @Override
    public Admin getAdminByUserName(String userName) {
        session = sessionFactory.getCurrentSession();

        Query query = session.createQuery("FROM Admin WHERE userName = ?1");
        query.setParameter(1, userName);
        return (Admin) query.getSingleResult();
    }
}
