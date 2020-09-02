package org.project.takeout.biz.impl;

import org.project.takeout.TakeOutException;
import org.project.takeout.TakeOutExceptionClassCode;
import org.project.takeout.biz.IAdminBiz;
import org.project.takeout.dao.IAdminDao;
import org.project.takeout.pojo.Admin;
import org.project.takeout.util.ContextHolderUtils;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

@Component("adminBiz")
@Transactional
public class AdminBizImpl implements IAdminBiz {
    @Resource
    private IAdminDao adminDao;

    static {
        TakeOutException.setException(TakeOutExceptionClassCode.ADMIN_BIZ, IAdminBiz.SUB_CODE_NOT_LOGIN, "Not login");
    }

    @Override
    public boolean login(Admin admin) {
        HttpSession session = ContextHolderUtils.getSession();

        if (adminDao.checkUserNameAndPassword(admin))
        {
            Admin admin1 = adminDao.getAdminByUserName(admin.getUserName());
            session.setAttribute("admin", admin1);
            return true;
        } else
            return false;
    }

    @Override
    public boolean changePassword(int adminID, String oldPassword, String newPassword) {
        return adminDao.changePassword(adminID, oldPassword, newPassword);
    }

    @Override
    public boolean isLogin() {
        HttpSession session = ContextHolderUtils.getSession();

        return session.getAttribute("admin") != null;
    }

    @Override
    public void logout() throws TakeOutException {
        HttpSession session = ContextHolderUtils.getSession();

        if (session.getAttribute("admin") != null)
            session.removeAttribute("admin");
        else
            throw new TakeOutException(TakeOutExceptionClassCode.ADMIN_BIZ, IAdminBiz.SUB_CODE_NOT_LOGIN);
    }

    @Override
    public Admin getCurrentAdmin() {
        HttpSession session = ContextHolderUtils.getSession();

        return (Admin) session.getAttribute("admin");
    }
}
