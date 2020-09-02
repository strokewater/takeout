package org.project.takeout.biz;

import org.project.takeout.TakeOutException;
import org.project.takeout.pojo.Admin;

public interface IAdminBiz {
    public static int SUB_CODE_NOT_LOGIN = 0;

    boolean login(Admin admin);
    void logout() throws TakeOutException;
    boolean isLogin();
    Admin getCurrentAdmin();
    boolean changePassword(int adminID, String oldPassword, String newPassword);
}
