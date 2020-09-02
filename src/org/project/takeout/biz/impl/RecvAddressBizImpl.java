package org.project.takeout.biz.impl;

import org.project.takeout.biz.IRecvAddressBiz;
import org.project.takeout.dao.IRecvAddressDao;
import org.project.takeout.pojo.RecvAddress;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Set;

@Component("recvAddressBiz")
public class RecvAddressBizImpl implements IRecvAddressBiz {
    @Resource(name = "recvAddressDao")
    private IRecvAddressDao recvAddressDao;

    @Override
    @Transactional
    public void add(int customerID, RecvAddress address) {
        recvAddressDao.add(customerID, address);
    }

    @Override
    @Transactional
    public void edit(int customerID, RecvAddress address) {
        recvAddressDao.edit(customerID, address);
    }

    @Override
    @Transactional
    public void delete(int customerID, int recvAddressID) {
        recvAddressDao.delete(customerID, recvAddressID);
    }

    @Override
    @Transactional
    public Set getAllItems(int customerID) {
        return recvAddressDao.getAllItems(customerID);
    }
}
