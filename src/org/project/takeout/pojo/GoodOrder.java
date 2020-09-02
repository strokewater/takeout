package org.project.takeout.pojo;

import org.springframework.stereotype.Component;

import javax.persistence.OneToMany;
import java.util.Date;
import java.util.Set;

@Component("goodOrder")
public class GoodOrder {
    private int id;
    private Customer customer;
    private int state;
    private String notice;
    private String comment;

    private String receiveAddress;
    private String receiverName;
    private String receiverPhone;

    private Date orderTime;
    private Date outStoreTime;
    private Date finishTime;

    private double totalPrice;

    private Set<GoodOrderList> goodList;

    public static final int STATE_PREPARE = 0;
    public static final int STATE_WAIT_CARRIER = 1;
    public static final int STATE_REACH = 2;


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getOrderTime() {
        return orderTime;
    }

    public void setOrderTime(Date orderTime) {
        this.orderTime = orderTime;
    }

    public Date getOutStoreTime() {
        return outStoreTime;
    }

    public void setOutStoreTime(Date outStoreTime) {
        this.outStoreTime = outStoreTime;
    }

    public Date getFinishTime() {
        return finishTime;
    }

    public void setFinishTime(Date finishTime) {
        this.finishTime = finishTime;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Set<GoodOrderList> getGoodList() {
        return goodList;
    }

    public void setGoodList(Set<GoodOrderList> goodList) {
        this.goodList = goodList;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getNotice() {
        return notice;
    }

    public void setNotice(String notice) {
        this.notice = notice;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getReceiveAddress() {
        return receiveAddress;
    }

    public void setReceiveAddress(String receiveAddress) {
        this.receiveAddress = receiveAddress;
    }

    public String getReceiverName() {
        return receiverName;
    }

    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }

    public String getReceiverPhone() {
        return receiverPhone;
    }

    public void setReceiverPhone(String receiverPhone) {
        this.receiverPhone = receiverPhone;
    }
}
