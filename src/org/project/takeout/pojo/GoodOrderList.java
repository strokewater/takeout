package org.project.takeout.pojo;

import org.springframework.stereotype.Component;

import javax.annotation.Resource;

@Component("goodOrderList")
public class GoodOrderList {
    private int id;
    private int goodNum;
    private GoodOrder order;
    private Good good;


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getGoodNum() {
        return goodNum;
    }

    public void setGoodNum(int goodNum) {
        this.goodNum = goodNum;
    }

    public GoodOrder getOrder() {
        return order;
    }

    public void setOrder(GoodOrder order) {
        this.order = order;
    }

    public Good getGood() {
        return good;
    }

    public void setGood(Good good) {
        this.good = good;
    }
}
