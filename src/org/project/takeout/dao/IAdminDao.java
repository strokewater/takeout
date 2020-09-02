package org.project.takeout.dao;

import org.project.takeout.pojo.Admin;

public interface IAdminDao {
    boolean checkUserNameAndPassword(Admin admin);
    boolean changePassword(int adminID, String oldPassword, String newPassword);
    Admin getAdminByUserName(String userName);
}
