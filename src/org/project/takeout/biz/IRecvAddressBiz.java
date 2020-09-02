package org.project.takeout.biz;

import org.project.takeout.pojo.RecvAddress;

import java.util.Set;

public interface IRecvAddressBiz {
    void add(int customerID, RecvAddress address);
    void edit(int customerID, RecvAddress address);
    void delete(int customerID, int recvAddressID);
    Set getAllItems(int customerID);
}
