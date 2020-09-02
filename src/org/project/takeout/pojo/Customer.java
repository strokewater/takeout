package org.project.takeout.pojo;

import org.springframework.stereotype.Component;


import javax.persistence.OneToMany;
import javax.persistence.criteria.CriteriaBuilder;
import java.util.Set;

@Component("customer")
public class Customer {
    private int id;
    private String userName;
    private String nickName;
    private String gender;
    private String password;
    private String email;
    private Set<GoodOrder> goodOrders;
    private Set<ShoppingCartItem> shoppingCartItems;
    private Set<RecvAddress> recvAddresses;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }


    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Set<GoodOrder> getGoodOrders() {
        return goodOrders;
    }

    public void setGoodOrders(Set<GoodOrder> goodOrders) {
        this.goodOrders = goodOrders;
    }

    public Set<ShoppingCartItem> getShoppingCartItems() {
        return shoppingCartItems;
    }

    public void setShoppingCartItems(Set<ShoppingCartItem> shoppingCartItems) {
        this.shoppingCartItems = shoppingCartItems;
    }

    public Set<RecvAddress> getRecvAddresses() {
        return recvAddresses;
    }

    public void setRecvAddresses(Set<RecvAddress> recvAddresses) {
        this.recvAddresses = recvAddresses;
    }

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
